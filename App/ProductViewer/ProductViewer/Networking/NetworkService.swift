//
//  NetworkService.swift
//  ProductViewer
//
//  Created by Akashlal Bathe on 14/09/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation

protocol NetworkServiceable {
    
    associatedtype T
    func fetch(request: URLRequest) async throws -> T
}

class NetworkService<T: Decodable>: NetworkServiceable {
    func fetch(request: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        let object = try JSONDecoder().decode(T.self, from: data)
        return object
    }
    
    
}
