//
//  CardsPositionCalculator.swift
//  CardAnimation
//
//  Created by Petre.
//  Copyright © 2019 Petre. All rights reserved.
//

import CoreGraphics

final class CardsPositionCalculator {
    private let configuration: CardsGeometricalConfiguration
    private var superviewSize: CGSize = .zero
    
    init(configuration: CardsGeometricalConfiguration) {
        self.configuration = configuration
    }
    
    func setup(superviewSize: CGSize) {
        self.superviewSize = superviewSize
    }
    
    var slotSize: CGSize {
        switch configuration.cardSize {
        case .custom(let size): return size
        case .default: return defaultSlotSize
        }
    }
    
    var extremePoint: CGPoint {
        return CGPoint(x: extremeXValue, y: centerYValue(index: 0, scale: 1))
    }
    
    func slotGeometrics(index: Int) -> (center: CGPoint, transform:  CGAffineTransform) {
        let scale = pow(configuration.scaleVariance, CGFloat(index))
        let transform: CGAffineTransform = index == 0 ? .identity : .init(scaleX: scale, y: scale)
        let center =  CGPoint(x: configuration.cardOffsets.horizontal,
                              y: centerYValue(index: index, scale: scale))

        return (center, transform)
    }
    
    // MARK: - Private
    
    private var extremeXValue: CGFloat {
        let value = (superviewSize.width + slotSize.width) / 2
        switch configuration.extremePointPosition {
        case .right: return value
        case .left: return -value
        }
    }
    
    private func centerYValue(index: Int, scale: CGFloat) -> CGFloat {
        let size = slotSize
        let originalYCenter = (superviewSize.height - size.height) / 2
        let slotDistance = configuration.cardOffsets.distance * CGFloat(index)

        return originalYCenter - (size.height - size.height * scale) / 2 - slotDistance + configuration.cardOffsets.vertical
    }

    private var defaultSlotSize: CGSize {
        let sizeScale: CGFloat = 0.8
        let maxSlotSize = CGSize(width: superviewSize.width * sizeScale, height: superviewSize.height * sizeScale)
        if maxSlotSize.width > maxSlotSize.height {
            return CGSize(width: maxSlotSize.height, height: maxSlotSize.height)
        } else {
            return CGSize(width: maxSlotSize.width, height: maxSlotSize.width)
        }
    }
}
