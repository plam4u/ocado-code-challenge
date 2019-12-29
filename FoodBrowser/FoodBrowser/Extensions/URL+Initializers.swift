//
//  URL+Initializers.swift
//  FoodBrowser
//
//  Created by Plamen on 12/28/19.
//  Copyright © 2019 Pixel Generator. All rights reserved.
//
// Extracted from a blog post by John Sundell
// Source: https://www.swiftbysundell.com/articles/constructing-urls-in-swift/#static-urls

import Foundation

extension URL {
    init(staticString string: StaticString) {
        guard let url = URL(string: "\(string)") else {
            preconditionFailure("Invalid static URL string: \(string)")
        }
        self = url
    }
}
