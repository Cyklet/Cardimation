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
    
    /// - Parameter cornerRadius: Slot corner radius
    /// - Parameter alphaDifference: The opacity difference that depends on the card deepness
    /// - Parameter swipeType: Cards swipe posibilities
    public init(cornerRadius: CGFloat = 4,
                alphaDifference: CGFloat = 0,
                swipeType: SwipeType = .autoManual) {
        self.cornerRadius = cornerRadius
        self.alphaDifference = alphaDifference
        self.swipeType = swipeType
    }
}

public enum SwipeType {
    /// Timer and swipe gestures will be enabled
    case autoManual
    /// Only timer will be enabled
    case automatic
    /// Only swipe gestures will be enabled
    case manual
}
