//
//  CardsPositionCalculator.swift
//  CardAnimation
//
//  Created by Petre.
//  Copyright © 2019 Petre. All rights reserved.
//

import Foundation

public struct CardRepresentation {
    let create: () -> CardViewable?
    let overlayConfiguration: OverlayConfiguration
    let displayTime: TimeInterval
    
    public init(create: @escaping () -> CardViewable?,
                overlayConfiguration: OverlayConfiguration = .init(),
                displayTime: TimeInterval = 3) {
        self.create = create
        self.overlayConfiguration = overlayConfiguration
        self.displayTime = displayTime
    }
}
