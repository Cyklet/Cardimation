import UIKit
import Cardimation

extension UILabel: CardViewable {
    public func setup(_ data: CardData) {
        guard let data = data as? String else { return }
        text = data
    }
}
