//
//  CardsPositionCalculator.swift
//  CardAnimation
//
//  Created by Petre.
//  Copyright © 2019 Petre. All rights reserved.
//

import UIKit

public protocol CardViewable: UIView {
    func setup(_ data: CardData)
}

public protocol OverlayViewable: UIView { }

public protocol CardData { }
