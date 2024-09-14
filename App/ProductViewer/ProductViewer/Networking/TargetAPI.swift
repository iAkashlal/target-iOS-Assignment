//
//  TargetAPI.swift
//  ProductViewer
//
//  Created by Akashlal Bathe on 14/09/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation

enum TargetAPI {
    case deals
    case productDetail(id: Int)
}

extension TargetAPI: NetworkRequest {
    var scheme: String {
        "https"
    }
    
    var host: String {
        "api.target.com"
    }
    
    var version: String {
        "/mobile_case_study_deals/v1"
    }
    
    var path: String {
        switch self {
        case .deals:
            "/deals"
        case .productDetail(let id):
            "/deals/\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .deals:
                .get
        case .productDetail(_):
                .get
        }
    }
    
    var headers: [String : String]? {
        ["content-type":"application/json"]
    }
    
    var body: Data? {
        nil
    }
    
    var queryParameters: [String : String] {
        switch self {
        case .deals:
            [:]
        case .productDetail(_):
            [:]
        }
    }
    
    
}
