//
//  String+.swift
//  ProductViewer
//
//  Created by Akashlal Bathe on 15/09/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation

extension String {
    func asURL() -> URL? {
        return URL(string: self)
    }
}
