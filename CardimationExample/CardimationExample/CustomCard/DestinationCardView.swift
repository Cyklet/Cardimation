//
//  CardsPositionCalculator.swift
//  CardAnimation
//
//  Created by Petre.
//  Copyright © 2019 Petre. All rights reserved.
//
import Cardimation
import UIKit

class DestinationCardView: UIView, CardViewable, OverlayViewable, NibLoadableView {
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var mainTextLabel: UILabel!
    @IBOutlet weak var subTextLabel: UILabel!
    @IBOutlet weak var imageComponentsView: UIView!
    @IBOutlet weak var picturesView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        layoutIfNeeded()
    }
    
    func setup(_ data: Landscape) {
        mainTextLabel.text = data.name
        subTextLabel.text = data.location
        cardImageView.image = UIImage(named: data.imageName)
    }
}
