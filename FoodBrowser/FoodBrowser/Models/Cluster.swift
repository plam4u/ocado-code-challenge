//
//  Cluster.swift
//  FoodBrowser
//
//  Created by Plamen on 12/28/19.
//  Copyright © 2019 Pixel Generator. All rights reserved.
//

import Foundation

/// Models the response received from the `clusters` API endpoint
struct ClustersContainer: Decodable {
    let clusters: [Cluster]
}

/// Models a cluster of products. A cluster is a category or a group of items.
struct Cluster: Decodable {
    let name: String
    let products: [ProductPreview]

    enum CodingKeys: String, CodingKey {
        case name = "tag"
        case products = "items"
    }
}
