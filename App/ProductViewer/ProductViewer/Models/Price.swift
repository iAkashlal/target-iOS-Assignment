//
//  Price.swift
//  ProductViewer
//
//  Created by Akashlal Bathe on 14/09/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation

struct Price: Codable {
    let amountInCents: Int
    let currencySymbol: String
    let displayString: String
}
