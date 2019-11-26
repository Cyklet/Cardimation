import Cardimation
import UIKit

final class CardCell: UITableViewCell, NibLoadableView {
    var cardsView: CardsView?

    func setup(cards: [CardRepresentation]) {
        cardsView?.removeFromSuperview()
        let configuration = CardsViewConfiguration(general: .init(alphaDifference: 0))
        let view = CardsView(cards: cards, numberOfSlots: 3, configuration: configuration)
        cardsView = view
        contentView.embedSubview(view)
        layoutIfNeeded()
        view.show()
    }
}
