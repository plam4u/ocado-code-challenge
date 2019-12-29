//
//  EndpointLoading.swift
//  FoodBrowser
//
//  Created by Plamen on 12/29/19.
//  Copyright © 2019 Pixel Generator. All rights reserved.
//

import Foundation

protocol EndpointLoading {
    @discardableResult
    func load<A>(_ e: Endpoint<A>, onComplete: @escaping (Result<A, Error>) -> ()) -> URLSessionDataTask
}

extension URLSession: EndpointLoading { }
