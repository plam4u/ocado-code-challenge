//
//  ProductListDataSourceTests.swift
//  FoodBrowserTests
//
//  Created by Plamen on 12/29/19.
//  Copyright © 2019 Pixel Generator. All rights reserved.
//

import XCTest
@testable import FoodBrowser

class ProductListDataSourceTests: XCTestCase {

    var dataLoaderMock: ProductListDataLoaderMock!
    var sut: ProductListDataSource!

    override func setUp() {
        super.setUp()
        dataLoaderMock = ProductListDataLoaderMock()
        sut = ProductListDataSource(dataLoader: dataLoaderMock)
    }

    func testLoadData() {
        // When
        sut.loadData()

        // Then
        XCTAssertTrue(dataLoaderMock.loadDataCalled)
    }

    func testProductById() {
        // Given
        dataLoaderMock.clustersToLoad = MockData.clusters
        sut.loadData()

        // When
        let actualProductId = sut.productId(at: IndexPath(row: 0, section: 0))

        // Then
        XCTAssertEqual(123, actualProductId) // 123 is the hardcoded product id in MockData
    }

    func testTableViewDataSource() {
        // Given
        dataLoaderMock.clustersToLoad = MockData.clusters
        sut.loadData()
        let tableView = UITableView()

        // When
        let numberOfSections = sut.numberOfSections(in: tableView)
        let numberOfRows = sut.tableView(tableView, numberOfRowsInSection: 0)
        let titleForHeader = sut.tableView(tableView, titleForHeaderInSection: 0)

        // Then
        XCTAssertEqual(1, numberOfSections)
        XCTAssertEqual(1, numberOfRows)
        XCTAssertEqual("Cluster Header", titleForHeader)
    }

    func testTableViewDataSourceCellRegistration() {
        // Given
        let tableViewSpy = TableViewSpy()

        // When
        sut.tableView = tableViewSpy

        // Then
        XCTAssertEqual(true, tableViewSpy.registerCalled)
        XCTAssertNotNil(tableViewSpy.registeredClass)
    }
}

class ProductListDataLoaderMock: ProductListDataLoaderProtocol {
    var loadDataCalled = false
    var clustersToLoad: [Cluster] = []

    func loadData(completion: @escaping ([Cluster]) -> Void) {
        loadDataCalled = true
        completion(clustersToLoad)
    }
}

extension ProductPreview: Equatable {
    public static func == (lhs: ProductPreview, rhs: ProductPreview) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title
    }
}

class TableViewSpy: UITableView {
    var registerCalled = false
    var registeredClass: AnyClass? = nil
    var registeredIdentifier: String = ""

    override func register(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        registerCalled = true
        registeredClass = cellClass
        registeredIdentifier = identifier
    }
}
