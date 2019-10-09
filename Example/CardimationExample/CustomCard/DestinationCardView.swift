//
//  CardsPositionCalculator.swift
//  CardAnimation
//
//  Created by Petre.
//  Copyright © 2019 Petre. All rights reserved.
//
import Cardimation
import UIKit

struct ExampleData: CardData {
    let title: String
    let description: String
    let image: UIImage?
    
    static func mocked(title: String = "View",
                description: String = "I am a custom",
                image: UIImage? = UIImage(named: "catalina")) -> CardData {
        return ExampleData(title: title, description: description, image: image)
    }
}

class DestinationCardView: UIView, CardViewable, OverlayViewable, NibLoadableView {
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var mainTextLabel: UILabel!
    @IBOutlet weak var subTextLabel: UILabel!
    @IBOutlet weak var imageComponentsView: UIView!
    @IBOutlet weak var picturesView: UIView!
    @IBOutlet weak var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        layoutIfNeeded()
    }
    
    func setup(_ information: CardData) {
        guard let data = information as? ExampleData else { return }
        mainTextLabel.text = data.title
        subTextLabel.text = data.description
        cardImageView.image = data.image
    }
}
