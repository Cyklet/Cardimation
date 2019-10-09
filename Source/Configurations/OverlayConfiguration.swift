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
    
    public init(type: OverlayType = .color(.init(white: 0, alpha: 0.8)),
         animationStyle: OverlayAnimationStyle = .animated(.init(duration: 1))) {
        self.type = type
        self.animationStyle = animationStyle
    }
}

public enum OverlayType {
    case none
    case color(UIColor)
    case custom(() -> OverlayViewable?)
}

public enum OverlayAnimationStyle {
    case animated(CardViewAnimationsConfiguration)
    case unanimated
}
