//
//  UIView+AutoLayout.swift
//  FoodBrowser
//
//  Created by Plamen on 12/29/19.
//  Copyright © 2019 Pixel Generator. All rights reserved.
//

import UIKit

extension UIView {
    func pinToEdges(of view: UIView) {
        if superview == nil {
            view.addSubview(self)
        }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
