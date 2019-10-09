//
//  CardsPositionCalculator.swift
//  CardAnimation
//
//  Created by Petre.
//  Copyright © 2019 Petre. All rights reserved.
//

public struct CardsViewConfiguration {
    let general: CardsGeneralConfiguration
    let geometrical: CardsGeometricalConfiguration
    let slots: CardsViewSlotsConfiguration
    let animations: CardViewAnimationsConfiguration
    
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
