//
//  CardsPositionCalculator.swift
//  CardAnimation
//
//  Created by Petre.
//  Copyright © 2019 Petre. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    
    func embedSubview(_ subview: UIView, insets: UIEdgeInsets = .zero) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        NSLayoutConstraint.activate(subview.createConstraintsForEmbedding(in: self, insets: insets))
    }
    
    func createConstraintsForEmbedding(in view: UIView, insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        return [
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right)
        ]
    }
    
}
