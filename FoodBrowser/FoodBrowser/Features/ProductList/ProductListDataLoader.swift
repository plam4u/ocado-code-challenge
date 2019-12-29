//
//  ProductListDataLoader.swift
//  FoodBrowser
//
//  Created by Plamen on 12/28/19.
//  Copyright © 2019 Pixel Generator. All rights reserved.
//

import Foundation

protocol ProductListDataLoaderProtocol {
    func loadData(completion: @escaping([Cluster]) -> Void)
}

/// Loads clusters of products using the provided Catalogue API dependency
struct ProductListDataLoader: ProductListDataLoaderProtocol {
    private let catalogue: CatalogueAPI
    private let loader: EndpointLoading
    
    init(catalogue: CatalogueAPI, loader: EndpointLoading = URLSession.shared) {
        self.catalogue = catalogue
        self.loader = loader
    }

    func loadData(completion: @escaping([Cluster]) -> Void) {
        loader.load(self.catalogue.clusters()) { result in
            DispatchQueue.main.async {
                if case .success(let clusters) = result {
                    completion(clusters)
                } else {
                    completion([]) // ignore errors by showing empty list
                }
            }
        }
    }
}
