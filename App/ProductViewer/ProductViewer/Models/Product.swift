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
    let isDiscounted: Bool

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
        
        if let salePrice = salePrice {
            isDiscounted = true
        } else {
            isDiscounted = false
        }
    }
    
    static func mockProduct() -> Product {
        let jsonData = """
        {
          "id": 1,
          "title": "TCL 32 Class 3-Series HD Smart Roku TV",
          "aisle": "g33",
          "description": "The 3-Series TCL Roku TV puts all your entertainment favorites in one place, allowing seamless access to thousands of streaming channels. The simple, personalized home screen allows seamless access to thousands of streaming channels, plus your cable box, Blu-ray player, gaming console, and other devices without flipping through inputs or complicated menus. Easy Voice Control lets you control your entertainment using just your voice. The super-simple remote—with about half the number of buttons on a traditional TV remote—puts you in control of your favorite entertainment. Cord cutters can access free, over-the-air HD content with the Advanced Digital TV Tuner or watch live TV from popular cable-replacement services like YouTube TV, Sling, Hulu and more.",
          "image_url": "https://www.wolflair.com/wp-content/uploads/2017/01/placeholder.jpg",
          "regular_price": {
            "amount_in_cents": 20999,
            "currency_symbol": "$",
            "display_string": "$209.99"
          },
          "sale_price": {
            "amount_in_cents": 15999,
            "currency_symbol": "$",
            "display_string": "$159.99"
          },
          "fulfillment": "Online",
          "availability": "In stock"
        }
        """.data(using: .utf8)!
        
        return try! JSONDecoder().decode(Product.self, from: jsonData)
        
    }
    
    
}

extension Product: Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id &&
                       lhs.title == rhs.title &&
                       lhs.aisle == rhs.aisle &&
                       lhs.description == rhs.description &&
                       lhs.imageUrl == rhs.imageUrl &&
                       lhs.regularPrice == rhs.regularPrice &&
                       lhs.salePrice == rhs.salePrice &&
                       lhs.fulfillment == rhs.fulfillment &&
                       lhs.availability == rhs.availability &&
                       lhs.stockInfo == rhs.stockInfo &&
                       lhs.isDiscounted == rhs.isDiscounted
    }
    
    
}
