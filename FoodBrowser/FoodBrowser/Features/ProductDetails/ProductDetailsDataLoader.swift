//
//  ProductDetailsLoader.swift
//  FoodBrowser
//
//  Created by Plamen on 12/28/19.
//  Copyright © 2019 Pixel Generator. All rights reserved.
//

import Foundation

struct ProductDetailsDataLoader {
    let catalogue: CatalogueAPI

    init(catalogue: CatalogueAPI) {
        self.catalogue = catalogue
    }

    func loadData(productId: Int, completion: @escaping(ProductDetails?) -> Void) {
        URLSession.shared.load(catalogue.product(id: productId)) { result in
            DispatchQueue.main.async {
                if case .success(let product) = result {
                    completion(product)
                } else {
                    completion(nil) // ignore errors
                }
            }
        }
    }
}
