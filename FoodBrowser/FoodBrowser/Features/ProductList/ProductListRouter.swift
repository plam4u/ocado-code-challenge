//
//  ProductListRouter.swift
//  FoodBrowser
//
//  Created by Plamen on 12/28/19.
//  Copyright © 2019 Pixel Generator. All rights reserved.
//

import UIKit

struct ProductListRouter {
    let navigationController: UINavigationController
    let detailViewFactory: (Int) -> UIViewController

    func goToProductDetails(id: Int) {
        let productDetailViewController = detailViewFactory(id)
        navigationController.pushViewController(productDetailViewController, animated: true)
    }
}
