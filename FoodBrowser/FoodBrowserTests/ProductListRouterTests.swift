//
//  ProductListRouterTests.swift
//  FoodBrowserTests
//
//  Created by Plamen on 12/29/19.
//  Copyright © 2019 Pixel Generator. All rights reserved.
//

import XCTest
@testable import FoodBrowser

class ProductListRouterTests: XCTestCase {

    func testGoToProductDetails() {
        // Given
        let someProductId = 0
        let navigationSpy = NavigationControllerSpy()
        let sut = ProductListRouter(navigationController: navigationSpy,
                                    detailViewFactory: { _ in UIViewController()})

        // When
        sut.goToProductDetails(id: someProductId)

        // Then
        XCTAssertEqual(true, navigationSpy.pushViewControllerCalled)
    }
}

class NavigationControllerSpy: UINavigationController {
    var pushViewControllerCalled = false
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCalled = true
    }
}
