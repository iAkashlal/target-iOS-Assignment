//
//  Produce.swift
//  ProductViewer
//
//  Created by Akashlal Bathe on 14/09/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation

enum StockInfo: String, Codable {
    case inStock
    case soldOut
}

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
    let stockInfo: StockInfo

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case aisle
        case description
        case imageUrl = "image_url"
        case regularPrice = "regular_price"
        case salePrice = "sale_price"
        case fulfillment
        case availability
    }

    // Custom init to set `stockInfo` during decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        aisle = try container.decode(String.self, forKey: .aisle)
        description = try container.decode(String.self, forKey: .description)
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        regularPrice = try container.decodeIfPresent(Price.self, forKey: .regularPrice)
        salePrice = try container.decodeIfPresent(Price.self, forKey: .salePrice)
        fulfillment = try container.decode(String.self, forKey: .fulfillment)
        availability = try container.decode(String.self, forKey: .availability)

        // Set stockInfo based on availability - Fragile implementation, can easily break but worst case shows instock as out of stock.
        if availability == "In stock" {
            stockInfo = .inStock
        } else {
            stockInfo = .soldOut
        }
    }
}
