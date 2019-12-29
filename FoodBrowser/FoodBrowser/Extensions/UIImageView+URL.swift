//
//  UIImageView+URL.swift
//  FoodBrowser
//
//  Created by Plamen on 12/29/19.
//  Copyright © 2019 Pixel Generator. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }

        URLSession.shared.load(Endpoint(imageURL: url)) { result in
            if case .success(let image) = result {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }

    }
}
