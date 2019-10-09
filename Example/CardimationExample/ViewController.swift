import UIKit
import Cardimation

final class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var cardsView: CardsView?
    @IBOutlet private var table: UITableView!
    @IBOutlet private var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCardView()
        table.register(CardCell.nib, forCellReuseIdentifier: CardCell.nibName)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        cardsView?.show()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.nibName, for: indexPath)
        (cell as? CardCell)?.setup(cards: [customCard, labelCard, labelCustomOverlayCard])
    
        return cell
    }

    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    // MARK: - Private functions
    
    private func addCardView() {
        let view = CardsView(cards: [customCard, labelCard, labelCustomOverlayCard],
                                     numberOfSlots: 4)
        cardsView = view
        containerView.embedSubview(view)
        containerView.clipsToBounds = true
    }
    
    // MARK: - Cards Views

    private var labelCard: CardRepresentation {
        return CardRepresentation(create: {
            let label = UILabel(frame: .zero)
            label.backgroundColor = .purple
            label.textAlignment = .center
            label.setup("I am a label")
            return label
        }, overlayConfiguration: OverlayConfiguration(type: .color(.black)), displayTime: 1.5)
    }
    
    private var labelCustomOverlayCard: CardRepresentation {
        let overlayConfig = OverlayConfiguration(type: .custom({ [weak self] in
            return self?.destinationCardView
        }))
        return CardRepresentation(create: {
            let label = UILabel(frame: .zero)
            label.backgroundColor = .blue
            label.textAlignment = .center
            label.numberOfLines = 0
            label.setup("I am another label")
            return label
        }, overlayConfiguration: overlayConfig, displayTime: 1.5)
    }

    private var customCard: CardRepresentation {
        return CardRepresentation(create: { [weak self] in
            return self?.destinationCardView
        }, displayTime: 1.7)
    }
    
    private var destinationCardView: CardViewable & OverlayViewable {
        let view = DestinationCardView.instantiate
        view.setup(ExampleData.mocked())
        
        return view
    }
}
