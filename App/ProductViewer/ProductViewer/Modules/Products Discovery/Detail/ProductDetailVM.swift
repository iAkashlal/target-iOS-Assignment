//
//  ProductDescriptionVM.swift
//  ProductViewer
//
//  Created by Akashlal Bathe on 14/09/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation

final class ProductDetailVM {
    
    var coordinator: Coordinator?
    var service: (any NetworkServiceable)?
    
    private(set) var product: Product?
    
    init(coordinator: Coordinator?, service: (any NetworkServiceable) = ProductDetailService()) {
        self.coordinator = coordinator
        self.service = service
    }
    
    func fetchDescriptionforProduct(with id: Int) {
        guard let service else {
            Logger.sharedInstance.log(
                message: "Service not initialized [\(#file.components(separatedBy: "/").last ?? "") - Line \(#line)]",
                logLevel: .error
            )
            return
        }
        
        guard let request = TargetAPI.productDetail(id: id).request else {
            Logger.sharedInstance.log(
                message: "URLRequest not available [\(#file.components(separatedBy: "/").last ?? "") - Line \(#line)]",
                logLevel: .error
            )
            return
        }
        
        Task {
            do {
                let product = try await service.fetch(request: request)
                Logger.sharedInstance.log(key: UUID().uuidString, message: "Product \(id) loaded", logLevel: .info)
            } catch let error {
                Logger.sharedInstance.log(
                    key: UUID().uuidString,
                    message: error.localizedDescription + "[\(#file.components(separatedBy: "/").last ?? "") - Line \(#line)]",
                    logLevel: .error
                )
            }
        }
    }
    
    
}
