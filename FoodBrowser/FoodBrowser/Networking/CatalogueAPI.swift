//
//  Catalogue.swift
//  FoodBrowser
//
//  Created by Plamen on 12/28/19.
//  Copyright © 2019 Pixel Generator. All rights reserved.
//

import Foundation

/// Describes the endpoints to connect to the Catalogue API
struct CatalogueAPI {
    let baseURL: URL = URL(staticString: "https://my-json-server.typicode.com/ocadotechnology/mobile-challenge")

    func clusters() -> Endpoint<[Cluster]> {
        let url = baseURL.appendingPathComponent("/products")
        return Endpoint<ClustersContainer>(json: .get, url: url).map { clustersContainer in
            return clustersContainer.clusters
        }
    }

    func product(id: Int) -> Endpoint<ProductDetails> {
        let url = baseURL.appendingPathComponent("/product/\(id)")
        return Endpoint(json: .get, url: url)
    }
}
