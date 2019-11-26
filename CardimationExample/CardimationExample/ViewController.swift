import UIKit
import Cardimation

final class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var cardsView: CardsView?
    @IBOutlet private var table: UITableView!
    @IBOutlet private var containerView: UIView!
    private let groups = [[Landscape(imageName: "angel-falls", location: "Venezuela", name: "Angel Falls"),
                           Landscape(imageName: "antarctica", location: "South Pole", name: "Antarctica"),
                           Landscape(imageName: "antelope-canyon", location: "Arizona", name: "Antelope Canyon"),
                           Landscape(imageName: "arashiyama-bamboo", location: "Japan", name: "Arashiyama")],
                          [Landscape(imageName: "atacama-desert", location: "Chile", name: "Atacama Desert"),
                           Landscape(imageName: "avenue-of-the-baobabs", location: "Madagascar", name: "Avenue of the Baobabs"),
                           Landscape(imageName: "azores", location: "Portugal", name: "Azores"),
                           Landscape(imageName: "banff-national-park", location: "Canada", name: "Banff National Park")],
                          [Landscape(imageName: "boracay", location: "Philippines", name: "Boracay"),
                           Landscape(imageName: "boulders-beach", location: "South Africa", name: "Boulders Beach"),
                           Landscape(imageName: "cabo-san-lucas", location: "Mexico", name: "Cabo San Lucas"),
                           Landscape(imageName: "cappadocia", location: "Turkey", name: "Cappadocia")],
                          [Landscape(imageName: "catalina", location: "California", name: "Catalina"),
                           Landscape(imageName: "faroe-islands", location: "Denmark", name: "Faroe"),
                           Landscape(imageName: "fernando-de-noronha", location: "Brazil", name: "Fernando de Noronha"),
                           Landscape(imageName: "ubud", location: "Indonesia", name: "Ubud")]]
    
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
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.nibName, for: indexPath)
        let cards = groups[indexPath.row].map { customCard(landscape: $0) }
        (cell as? CardCell)?.setup(cards: cards)
    
        return cell
    }

    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    // MARK: - Private functions
    
    private func addCardView() {
        guard let group = groups.last, let item = groups.first?.first else { return }
        let cards = [labelCustomOverlayCard(landscape: item)] + group.map { customCard(landscape: $0) }
        let view = CardsView(cards: cards, numberOfSlots: 4)
        cardsView = view
        containerView.embedSubview(view)
        containerView.clipsToBounds = true
        view.layoutIfNeeded()
    }
    
    // MARK: - Cards Views
    
    private func labelCustomOverlayCard(landscape: Landscape) -> CardRepresentation {
        let overlayConfig = OverlayConfiguration(type: .custom({ [weak self] in
            return self?.destinationCardView(landscape: landscape)
        }), animationStyle: .animated(.init(duration: 3)))
        return CardRepresentation(create: {
            let label = UILabel(frame: .zero)
            label.backgroundColor = UIColor(red: 0.99, green: 0.98, blue: 0.81, alpha: 1)
            label.textAlignment = .center
            label.numberOfLines = 0
            label.textColor = .black
            label.text = "You should visit it".uppercased()
            return label
        }, overlayConfiguration: overlayConfig, displayTime: 4)
    }

    private func customCard(landscape: Landscape) -> CardRepresentation {
        return CardRepresentation(create: { [weak self] in
            return self?.destinationCardView(landscape: landscape)
        }, displayTime: 1.7)
    }
    
    private func destinationCardView(landscape: Landscape) -> CardViewable & OverlayViewable {
        let view = DestinationCardView.instantiate
        view.setup(landscape)
        
        return view
    }
}

struct Landscape {
    let imageName: String
    let location: String
    let name: String
}
