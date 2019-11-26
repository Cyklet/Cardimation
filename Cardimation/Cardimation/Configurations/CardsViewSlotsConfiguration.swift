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
    
    /// - Parameter min: Minimal number of visible cards on the screen
    /// - Parameter max: Maximal number of visible cards on the screen
    public init(min: Int = 3, max: Int = 5) {
        self.min = min
        self.max = max
    }
}
