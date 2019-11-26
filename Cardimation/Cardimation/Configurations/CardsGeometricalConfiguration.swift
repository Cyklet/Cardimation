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
    
    /// - Parameter scaleVariance: The scale difference that depends on the card deepness
    /// - Parameter extremePointPosition: Position of the card where it will be moved
    /// - Parameter cardOffsets: The offset of the original centre position
    /// - Parameter cardSize: The card size type
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
    /// A right extreme position used for the left to right languages
    case right
    /// A left extreme position used for the right to left languages
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
    /// Horizontal offset from the centre of the super view
    let horizontal: CGFloat
    /// Vertical offset from the centre of the card slot
    let vertical: CGFloat
    /// Vertical distance between the current card and next card in the stack
    let distance: CGFloat
    
    public init(horizontal: CGFloat = 0, vertical: CGFloat = 0, distance: CGFloat = 10) {
        self.horizontal = horizontal
        self.vertical = vertical
        self.distance = distance
    }
}

public enum CardSizeType {
    /// Custom given size
    case custom(CGSize)
    /// Default size calculated by the maximal width or height
    case `default`
}
