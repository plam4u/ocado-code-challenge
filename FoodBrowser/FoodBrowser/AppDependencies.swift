//
//  AppDependencies.swift
//  FoodBrowser
//
//  Created by Plamen on 12/28/19.
//  Copyright © 2019 Pixel Generator. All rights reserved.
//

import UIKit

/// Compisition Root where all dependencies are instantiated and configured.
/// Objects should not create their dependencies themselves.
struct AppDependencies {
    let catalogue = CatalogueAPI()
    
    func installRootViewController(into window: UIWindow) {
        let rootViewController = UINavigationController()
        let productListRouter = ProductListRouter(navigationController: rootViewController,
                                                  detailViewFactory: createProductDetailViewController(productId:))

        let productListDataLoader = ProductListDataLoader(catalogue: catalogue)
        let productListDataSource = ProductListDataSource(dataLoader: productListDataLoader)
        let productListViewController = ProductListViewController(dataSource: productListDataSource,
                                                                  router: productListRouter)
        rootViewController.setViewControllers([productListViewController], animated: false)

        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }

    /// Lazily creates a Product Details View Controller
    /// - Parameter productId: the id of the product to load in the newly created view controller
    func createProductDetailViewController(productId: Int) -> UIViewController {
        let productDetailsLoader = ProductDetailsDataLoader(catalogue: catalogue)
        return ProductDetailsViewController(productId: productId, dataLoader: productDetailsLoader)
    }
}
