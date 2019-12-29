//
//  EndpointLoaderMock.swift
//  FoodBrowserTests
//
//  Created by Plamen on 12/29/19.
//  Copyright © 2019 Pixel Generator. All rights reserved.
//

import Foundation
@testable import FoodBrowser

class EndpointLoaderMock<A>: EndpointLoading {

    var result: Result<A, Error>?

    func load<A>(_ e: Endpoint<A>, onComplete: @escaping (Result<A, Error>) -> Void) -> URLSessionDataTask {
        let result: Result<A, Error> = self.result! as! Result<A, Error>

        // Just call the `onComplete` with the expected result
        onComplete(result)

        return URLSession.shared.dataTask(with: URL(staticString: "https://some.url/"))
    }
}
