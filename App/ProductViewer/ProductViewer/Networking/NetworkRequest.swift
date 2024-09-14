//
//  NetworkRequest.swift
//  ProductViewer
//
//  Created by Akashlal Bathe on 14/09/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case post = "PUT"
    case put = "POST"
    case get = "GET"
}

protocol NetworkRequest {
    var scheme: String {get}
    var host: String {get}
    var version: String {get}
    var path: String {get}
    var httpMethod: HTTPMethod {get}
    var headers: [String:String]? {get}
    var body: Data? {get}
    var queryParameters: [String: String] {get}
}

extension NetworkRequest {
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = version + path
        urlComponents.queryItems = queryParameters.compactMap({ key, value in
            return URLQueryItem(name: key, value: value)
        })
        return urlComponents.url
    }
    
    var request: URLRequest? {
        guard let url = url else {
            assertionFailure()
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body
        request.allHTTPHeaderFields = headers
        print(request)
        return request
    }
}


