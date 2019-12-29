//
//  Product.swift
//  FoodBrowser
//
//  Created by Plamen on 12/28/19.
//  Copyright © 2019 Pixel Generator. All rights reserved.
//

import Foundation

struct ProductDetails: Decodable {
    let id: Int
    let title: String
    let imageUrl: String
    let price: String
    let description: String
    let allergyInformation: String
}
