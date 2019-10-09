//
//  CardsGeometricalConfiguration.swift
//  CardAnimation
//
//  Created by Petre on 10/6/19.
//  Copyright © 2019 Petre. All rights reserved.
//

import UIKit

public struct CardsGeometricalConfiguration {
    let scaleVariance: CGFloat
    let extremePointPosition: ExtremePointPosition
    let cardOffsets: CardOffsets
    let cardSize: CardSizeType
    
    public init(scaleVariance: CGFloat = 0.9,
                extremePointPosition: ExtremePointPosition = .right,
                cardOffsets: CardOffsets = .init(),
                cardSize: CardSizeType = .default) {
        self.scaleVariance = scaleVariance
        self.extremePointPosition = extremePointPosition
        self.cardOffsets = cardOffsets
        self.cardSize = cardSize
    }
}

public enum ExtremePointPosition {
    case right
    case left
    
    var nextGestureDirection: UISwipeGestureRecognizer.Direction {
        switch self {
        case .right: return .right
        case .left: return .left
        }
    }
    
    var previousGestureDirection: UISwipeGestureRecognizer.Direction {
        switch self {
        case .right: return .left
        case .left: return .right
        }
    }
}

public struct CardOffsets {
    let horizontal: CGFloat
    let vertical: CGFloat
    let distance: CGFloat
    
    public init(horizontal: CGFloat = 0, vertical: CGFloat = 0, distance: CGFloat = 10) {
        self.horizontal = horizontal
        self.vertical = vertical
        self.distance = distance
    }
}

public enum CardSizeType {
    case custom(CGSize)
    case `default`
}
