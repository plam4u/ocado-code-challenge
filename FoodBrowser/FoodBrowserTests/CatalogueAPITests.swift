//
//  CatalogueAPITests.swift
//  FoodBrowserTests
//
//  Created by Plamen on 12/29/19.
//  Copyright © 2019 Pixel Generator. All rights reserved.
//

import XCTest
@testable import FoodBrowser

class CatalogueAPITests: XCTestCase {

    var sut = CatalogueAPI()

    func testClusters() throws {
        XCTAssertThrowsError(try sut.clusters().parse(invalidData, nil).get())
        XCTAssertNoThrow(try sut.clusters().parse(validClustersData, nil).get())
    }

    func testProduct() throws {
        XCTAssertThrowsError(try sut.product(id: 1).parse(invalidData, nil).get())
        XCTAssertNoThrow(try sut.product(id: 1).parse(validProductData, nil).get())
    }
}

let invalidData = "".data(using: .utf8)
let validClustersData = """
{
  "clusters": [
    {
      "tag": "Bananas",
      "items": [
        {
          "id": 309396011,
          "price": "1.45",
          "title": "Ocado Organic Fairtrade Bananas",
          "size": "6 per pack",
          "imageUrl": "https://mobile.ocado.com/webservices/catalogue/items/item/309396011/images/image/0/240x240.jpg"
        },
        {
          "id": 227255011,
          "price": "4.45",
          "title": "Ocado Fairtrade Ripen at Home Bananas",
          "size": "5 per pack",
          "imageUrl": "https://mobile.ocado.com/webservices/catalogue/items/item/227255011/images/image/0/240x240.jpg"
        }
      ]
    }
  ]
}
""".data(using: .utf8)

let validProductData = """
{
  "id": 309396011,
  "price": "1.45",
  "title": "Ocado Organic Fairtrade Bananas",
  "imageUrl": "https://mobile.ocado.com/webservices/catalogue/items/item/309396011/images/image/0/360x360.jpg",
  "description": "Organic. Suitable for vegetarians",
  "allergyInformation": "May contain traces of Sesame Seeds"
}
""".data(using: .utf8)
