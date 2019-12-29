//
//  ViewController.swift
//  FoodBrowser
//
//  Created by Plamen on 12/28/19.
//  Copyright © 2019 Pixel Generator. All rights reserved.
//

import UIKit

/// Displays product list grouped into clusters
class ProductListViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let dataSource: ProductListDataSource // store a strong reference
    private let router: ProductListRouter

    init(dataSource: ProductListDataSource, router: ProductListRouter) {
        self.dataSource = dataSource
        self.router = router

        super.init(nibName: nil, bundle: nil)

        // populate table view with data
        tableView.dataSource = dataSource

        // handle interactivity
        tableView.delegate = self

        // when new data received, trigger table view reload
        dataSource.tableView = tableView
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Storyboards are not supported.")
    }

    override func loadView() {
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.loadData()
    }
}

/// Handles row selection to navigate to the Product Details
extension ProductListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.goToProductDetails(id: dataSource.productId(at: indexPath))
    }
}
