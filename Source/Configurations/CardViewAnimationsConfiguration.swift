//
//  CardsPositionCalculator.swift
//  CardAnimation
//
//  Created by Petre.
//  Copyright © 2019 Petre. All rights reserved.
//

import UIKit

public struct CardViewAnimationsConfiguration {
    let duration: TimeInterval
    let delay: TimeInterval
    let options: UIView.AnimationOptions
    
    public init(duration: TimeInterval, delay: TimeInterval = 0, options: UIView.AnimationOptions = .curveEaseInOut) {
        self.duration = duration
        self.delay = delay
        self.options = options
    }
}
