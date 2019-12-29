//
//  ProductListDataSource.swift
//  FoodBrowser
//
//  Created by Plamen on 12/28/19.
//  Copyright © 2019 Pixel Generator. All rights reserved.
//

import UIKit

/// Feeds data into the Product List Table View
class ProductListDataSource: NSObject {
    /// stored to call `tableView.reloadData()`
    weak var tableView: UITableView? {
        didSet {
            tableView?.register(ProductTableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    
    /// the data used to puplate the table view
    private var clusters: [Cluster] = [] {
        didSet {
            self.tableView?.reloadData()
        }
    }

    /// loads clusters from server
    private let dataLoader: ProductListDataLoaderProtocol

    init(dataLoader: ProductListDataLoaderProtocol) {
        self.dataLoader = dataLoader
    }

    func loadData() {
        dataLoader.loadData { clusters in
            self.clusters = clusters
        }
    }

    func productId(at indexPath: IndexPath) -> Int {
        let targetProduct = product(at: indexPath)
        return targetProduct.id
    }

    private func product(at indexPath: IndexPath) -> ProductPreview {
        let cluster = clusters[indexPath.section]
        let product = cluster.products[indexPath.row]
        return product
    }
}

// MARK: - UITableViewDataSource

extension ProductListDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return clusters.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clusters[section].products.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return clusters[section].name
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Extract to a factory and inject from the Composition Root
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ProductTableViewCell else {
            fatalError("cell is not registered.")
        }

        let currentProduct = product(at: indexPath)
        cell.configure(with: currentProduct)
        return cell
    }
}
