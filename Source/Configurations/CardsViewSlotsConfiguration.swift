//
//  CardsPositionCalculator.swift
//  CardAnimation
//
//  Created by Petre.
//  Copyright © 2019 Petre. All rights reserved.
//

public struct CardsViewSlotsConfiguration {
    let min: Int
    let max: Int
    
    public init(min: Int = 3, max: Int = 5) {
        self.min = min
        self.max = max
    }
}
