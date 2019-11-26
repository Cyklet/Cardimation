//
//  CardsPositionCalculator.swift
//  CardAnimation
//
//  Created by Petre.
//  Copyright © 2019 Petre. All rights reserved.
//

import UIKit

private enum OverlayState {
    case hidden
    case visible
}

final class CardSlotView: UIView {
    private var overlay: OverlayViewable?
    private var overlayAnimationStyle: OverlayAnimationStyle = .unanimated
        
    lazy var horizontalContraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal,
                                                      toItem: self.superview, attribute: .centerX, multiplier: 1,
                                                      constant: 0)
    lazy var verticalConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal,
                                                     toItem: self.superview, attribute: .centerY, multiplier: 1,
                                                     constant: 0)
    lazy var widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal,
                                                  toItem: nil, attribute: .notAnAttribute, multiplier: 1,
                                                  constant: 0)
    lazy var heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal,
                                                   toItem: nil, attribute: .notAnAttribute, multiplier: 1,
                                                   constant: 0)
    
    func setup(card: CardViewable?, overlayConfiguration: OverlayConfiguration) {
        removeSubviews()
        overlayAnimationStyle = overlayConfiguration.animationStyle
        if let card = card { embedSubview(card) }
        addOverlay(type: overlayConfiguration.type)
    }
    
    func setup(size: CGSize) {
        widthConstraint.constant = size.width
        heightConstraint.constant = size.height
        layoutIfNeeded()
    }
    
    func setup(center: CGPoint) {
        horizontalContraint.constant = center.x
        verticalConstraint.constant = center.y
    }

    func hideOverlay() {
        guard overlay != nil else { return }
        switch overlayAnimationStyle {
        case .animated(let config): updateOverlay(state: .hidden, config: config)
        case .unanimated: overlay?.isHidden = true
        }
    }
    
    func showOverlay() {
        guard overlay != nil else { return }
        switch overlayAnimationStyle {
        case .animated(let config): updateOverlay(state: .visible, config: config)
        case .unanimated: overlay?.isHidden = false
        }
    }

    func removeSubviews() {
        overlay = nil
        subviews.forEach { $0.removeFromSuperview() }
    }

    // MARK: - Private functions

    private func addOverlay(type: OverlayType) {
        switch type {
        case .none:
            return
        case .color(let color):
            let view = ColoredOverlayView(color: color)
            overlay = view
            embedSubview(view)
        case .custom(let customOverlay):
            guard let view = customOverlay() else { return }
            overlay = view
            embedSubview(view)
        }
    }
    
    private func updateOverlay(state: OverlayState, config: CardViewAnimationsConfiguration) {
        let animations: () -> Void = { [weak self] in
            switch state {
            case .hidden: self?.overlay?.alpha = 0
            case .visible: self?.overlay?.alpha = 1
            }
        }
        UIView.animate(withDuration: config.duration,
                       delay: config.delay,
                       options: config.options,
                       animations: animations)
    }
}

private final class ColoredOverlayView: UIView, OverlayViewable {
    init(color: UIColor) {
        super.init(frame: .zero)
        backgroundColor = color
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
