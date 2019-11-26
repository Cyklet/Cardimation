//
//  CardsPositionCalculator.swift
//  CardAnimation
//
//  Created by Petre.
//  Copyright © 2019 Petre. All rights reserved.
//

import Foundation

/// A structure that has all the required information for the card to be shown on the slots
public struct CardRepresentation {
    let create: () -> CardViewable?
    let overlayConfiguration: OverlayConfiguration
    let displayTime: TimeInterval
    
    /// - Parameter create: The closure that returns the card view
    /// - Parameter overlayConfiguration: Configuration for the overlay on the top of the card
    /// - Parameter displayTime: Duration describing how long card is visible
    public init(create: @escaping () -> CardViewable?,
                overlayConfiguration: OverlayConfiguration = .init(),
                displayTime: TimeInterval = 3) {
        self.create = create
        self.overlayConfiguration = overlayConfiguration
        self.displayTime = displayTime
    }
}
