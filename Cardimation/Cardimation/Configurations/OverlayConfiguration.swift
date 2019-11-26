//
//  CardsPositionCalculator.swift
//  CardAnimation
//
//  Created by Petre.
//  Copyright © 2019 Petre. All rights reserved.
//

import UIKit

public struct OverlayConfiguration {
    let type: OverlayType
    let animationStyle: OverlayAnimationStyle
    
    /// - Parameter type: The type of overlay that will be placed above card
    /// - Parameter animationStyle: Animation style of the overlay
    public init(type: OverlayType = .color(.init(white: 0, alpha: 0.8)),
         animationStyle: OverlayAnimationStyle = .animated(.init(duration: 1))) {
        self.type = type
        self.animationStyle = animationStyle
    }
}

public enum OverlayType {
    /// No overlay will be added above card
    case none
    /// Simple overlay with color
    case color(UIColor)
    /// Custom overlay view
    case custom(() -> OverlayViewable?)
}

public enum OverlayAnimationStyle {
    case animated(CardViewAnimationsConfiguration)
    case unanimated
}
