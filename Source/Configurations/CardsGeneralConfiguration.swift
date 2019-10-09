//
//  CardsPositionCalculator.swift
//  CardAnimation
//
//  Created by Petre.
//  Copyright © 2019 Petre. All rights reserved.
//

import CoreGraphics

public struct CardsGeneralConfiguration {
    let cornerRadius: CGFloat
    let alphaDifference: CGFloat
    let swipeType: SwipeType
    
    public init(cornerRadius: CGFloat = 4,
                alphaDifference: CGFloat = 0,
                swipeType: SwipeType = .autoManual) {
        self.cornerRadius = cornerRadius
        self.alphaDifference = alphaDifference
        self.swipeType = swipeType
    }
}

public enum SwipeType {
    case autoManual
    case automatic
    case manual
}
