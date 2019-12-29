//
//  MockData.swift
//  FoodBrowserTests
//
//  Created by Plamen on 12/29/19.
//  Copyright © 2019 Pixel Generator. All rights reserved.
//

import Foundation
@testable import FoodBrowser

struct MockData {
    static var clusters: [Cluster] = [Cluster(name: "Cluster Header", products: [productPreview])]
    static var productPreview = ProductPreview(id: 123,
                                               title: "product title",
                                               imageUrl: "",
                                               price: "1.0")
}
