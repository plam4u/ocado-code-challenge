//
//  ProductDetailsViewController.swift
//  FoodBrowser
//
//  Created by Plamen on 12/28/19.
//  Copyright © 2019 Pixel Generator. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    enum ViewState {
        case loading
        case empty
        case content(ProductDetails)
    }

    private let productId: Int
    private let dataLoader: ProductDetailsDataLoader
    private var currentView = UIView()
    private var viewState: ViewState = .loading {
        didSet {
            updateUI()
        }
    }

    init(productId: Int, dataLoader: ProductDetailsDataLoader) {
        self.productId = productId
        self.dataLoader = dataLoader

        super.init(nibName: nil, bundle: nil)

        // set observers are not called from initializers,
        // thus we need to force the first UI update
        updateUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Storyboards are not supported.")
    }

    private func updateUI() {
        // remove previous view state
        if currentView.superview != nil {
            currentView.removeFromSuperview()
        }

        switch viewState {
        case .loading:
            title = "Loading…"
            currentView = LoadingView()

        case .empty:
            title = "Product Not Found"
            currentView = EmptyView()

        case .content(let product):
            title = product.title
            currentView = ProductDetailsView(product: product)
        }

        currentView.pinToEdges(of: view)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        dataLoader.loadData(productId: productId) { product in
            if let product = product {
                self.viewState = .content(product)
            } else {
                self.viewState = .empty
            }
        }
    }
}
