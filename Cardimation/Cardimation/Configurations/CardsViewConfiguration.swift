//
//  CardsPositionCalculator.swift
//  CardAnimation
//
//  Created by Petre.
//  Copyright © 2019 Petre. All rights reserved.
//

/// All available configurations for the cards view
public struct CardsViewConfiguration {
    let general: CardsGeneralConfiguration
    let geometrical: CardsGeometricalConfiguration
    let slots: CardsViewSlotsConfiguration
    let animations: CardViewAnimationsConfiguration
    
    /// - Parameter general: General configurations like cornerRadius, alphaDifference, swipeType
    /// - Parameter geometrical: Geometrical configurations like scaleVariance, extremePointPosition, cardOffsets, cardSize
    /// - Parameter slots: Slots configurations describing maximum and minimum available slots on the screen
    /// - Parameter animations: Configuration for card movement animation
    public init(general: CardsGeneralConfiguration = .init(),
                geometrical: CardsGeometricalConfiguration = .init(),
                slots: CardsViewSlotsConfiguration = .init(),
                animations: CardViewAnimationsConfiguration = .init(duration: 0.5)) {
        self.general = general
        self.geometrical = geometrical
        self.slots = slots
        self.animations = animations
    }
}
