//
//  Produce.swift
//  ProductViewer
//
//  Created by Akashlal Bathe on 14/09/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation

struct Product: Codable {
    let id: Int
    let title: String
    let aisle: String
    let description: String
    let imageUrl: String?
    let regularPrice: Price?
    let salePrice: Price?
    let fulfillment: String
    let availability: String
}
