// This is a trimmed version of TinyNetworking by Chris Eidhof from objc.io
// Source: https://github.com/objcio/tiny-networking

import Foundation

/// Built-in Content Types
public enum ContentType: String {
    case json = "application/json"
}

/// Returns `true` if `code` is in the 200..<300 range.
public func expected200to300(_ code: Int) -> Bool {
    return code >= 200 && code < 300
}

/// This describes an endpoint returning `A` values. It contains both a `URLRequest` and a way to parse the response.
public struct Endpoint<A> {

    /// The HTTP Method
    public enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }

    /// The request for this endpoint
    public var request: URLRequest

    /// This is used to (try to) parse a response into an `A`.
    var parse: (Data?, URLResponse?) -> Result<A, Error>

    /// This is used to check the status code of a response.
    var expectedStatusCode: (Int) -> Bool = expected200to300

    /// Transforms the result
    public func map<B>(_ f: @escaping (A) -> B) -> Endpoint<B> {
        return Endpoint<B>(request: request, expectedStatusCode: expectedStatusCode, parse: { value, response in
            self.parse(value, response).map(f)
        })
    }

    /// Create a new Endpoint.
    ///
    /// - Parameters:
    ///   - method: the HTTP method
    ///   - url: the endpoint's URL
    ///   - accept: the content type for the `Accept` header
    ///   - contentType: the content type for the `Content-Type` header
    ///   - body: the body of the request.
    ///   - headers: additional headers for the request
    ///   - expectedStatusCode: the status code that's expected. If this returns false for a given status code, parsing fails.
    ///   - timeOutInterval: the timeout interval for his request
    ///   - query: query parameters to append to the url
    ///   - parse: this converts a response into an `A`.
    public init(_ method: Method, url: URL, accept: ContentType? = nil, contentType: ContentType? = nil, body: Data? = nil, headers: [String:String] = [:], expectedStatusCode: @escaping (Int) -> Bool = expected200to300, timeOutInterval: TimeInterval = 10, query: [String:String] = [:], parse: @escaping (Data?, URLResponse?) -> Result<A, Error>) {
        var requestUrl : URL
        if query.isEmpty {
            requestUrl = url
        } else {
            var comps = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            comps.queryItems = comps.queryItems ?? []
            comps.queryItems!.append(contentsOf: query.map { URLQueryItem(name: $0.0, value: $0.1) })
            requestUrl = comps.url!
        }
        request = URLRequest(url: requestUrl)
        if let a = accept {
            request.setValue(a.rawValue, forHTTPHeaderField: "Accept")
        }
        if let ct = contentType {
            request.setValue(ct.rawValue, forHTTPHeaderField: "Content-Type")
        }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        request.timeoutInterval = timeOutInterval
        request.httpMethod = method.rawValue

        // body *needs* to be the last property that we set, because of this bug: https://bugs.swift.org/browse/SR-6687
        request.httpBody = body

        self.expectedStatusCode = expectedStatusCode
        self.parse = parse
    }


    /// Creates a new Endpoint from a request
    ///
    /// - Parameters:
    ///   - request: the URL request
    ///   - expectedStatusCode: the status code that's expected. If this returns false for a given status code, parsing fails.
    ///   - parse: this converts a response into an `A`.
    public init(request: URLRequest, expectedStatusCode: @escaping (Int) -> Bool = expected200to300, parse: @escaping (Data?, URLResponse?) -> Result<A, Error>) {
        self.request = request
        self.expectedStatusCode = expectedStatusCode
        self.parse = parse
    }
}

// MARK: - where A: Decodable
extension Endpoint where A: Decodable {
    /// Creates a new endpoint.
    ///
    /// - Parameters:
    ///   - method: the HTTP method
    ///   - url: the endpoint's URL
    ///   - accept: the content type for the `Accept` header
    ///   - headers: additional headers for the request
    ///   - expectedStatusCode: the status code that's expected. If this returns false for a given status code, parsing fails.
    ///   - query: query parameters to append to the url
    ///   - decoder: the decoder that's used for decoding `A`s.
    public init(json method: Method, url: URL, accept: ContentType = .json, headers: [String: String] = [:], expectedStatusCode: @escaping (Int) -> Bool = expected200to300, query: [String: String] = [:], decoder: JSONDecoder = JSONDecoder()) {
        self.init(method, url: url, accept: accept, body: nil, headers: headers, expectedStatusCode: expectedStatusCode, query: query) { data, _ in
            return Result {
                guard let dat = data else { throw NoDataError() }
                return try decoder.decode(A.self, from: dat)
            }
        }
    }
}

/// Signals that a response's data was unexpectedly nil.
public struct NoDataError: Error {
    public init() { }
}

/// An unknown error
public struct UnknownError: Error {
    public init() { }
}

/// Signals that a response's status code was wrong.
public struct WrongStatusCodeError: Error {
    public let statusCode: Int
    public let response: HTTPURLResponse?
    public init(statusCode: Int, response: HTTPURLResponse?) {
        self.statusCode = statusCode
        self.response = response
    }
}

extension URLSession {
    @discardableResult
    /// Loads an endpoint by creating (and directly resuming) a data task.
    ///
    /// - Parameters:
    ///   - e: The endpoint.
    ///   - onComplete: The completion handler.
    /// - Returns: The data task.
    public func load<A>(_ e: Endpoint<A>, onComplete: @escaping (Result<A, Error>) -> ()) -> URLSessionDataTask {
        let r = e.request
        let task = dataTask(with: r, completionHandler: { data, resp, err in
            if let err = err {
                onComplete(.failure(err))
                return
            }

            guard let h = resp as? HTTPURLResponse else {
                onComplete(.failure(UnknownError()))
                return
            }

            guard e.expectedStatusCode(h.statusCode) else {
                onComplete(.failure(WrongStatusCodeError(statusCode: h.statusCode, response: h)))
                return
            }

            onComplete(e.parse(data,resp))
        })
        task.resume()
        return task
    }
}

import UIKit
struct ImageError: Error {}

extension Endpoint where A == UIImage {
    init(imageURL: URL) {
        self = Endpoint(.get, url: imageURL) { data, _ in
            Result {
                guard let d = data, let i = UIImage(data: d) else { throw ImageError() }
                return i
            }
        }
    }
}
