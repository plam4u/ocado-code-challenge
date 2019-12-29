//
//  ProductListDataLoaderTests.swift
//  FoodBrowserTests
//
//  Created by Plamen on 12/29/19.
//  Copyright © 2019 Pixel Generator. All rights reserved.
//

import XCTest
@testable import FoodBrowser

class ProductListDataLoaderTests: XCTestCase {

    var endpointLoader = EndpointLoaderMock<[Cluster]>()
    var sut: ProductListDataLoader!

    override func setUp() {
        super.setUp()
        sut = ProductListDataLoader(catalogue: CatalogueAPI(), loader: endpointLoader)
    }

    func testDataLoaderSuccess() {
        // Given
        endpointLoader.result = .success(MockData.clusters)
        let clustersExpectation = expectation(description: "Load and parse clusters.")
        var clusters: [Cluster]? = nil

        // When
        sut.loadData { loadedClusters in
            clusters = loadedClusters
            clustersExpectation.fulfill()
        }
        waitForExpectations(timeout: 0.5)

        // Then
        XCTAssertNotNil(clusters)
        XCTAssertNotEqual(0, clusters?.count)
    }

    func testDataLoaderFailure() {
        // Given
        endpointLoader.result = .failure(UnknownError())
        let clustersExpectation = expectation(description: "Completed with failure.")
        var clusters: [Cluster]? = nil

        // When
        sut.loadData { loadedClusters in
            clusters = loadedClusters
            clustersExpectation.fulfill()
        }
        waitForExpectations(timeout: 0.5)

        // Then
        XCTAssertNotNil(clusters)
        XCTAssertEqual(0, clusters?.count, "Should be empty array")
    }
}
