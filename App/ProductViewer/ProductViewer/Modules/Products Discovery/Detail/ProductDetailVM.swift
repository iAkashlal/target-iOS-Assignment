//
//  ProductDescriptionVM.swift
//  ProductViewer
//
//  Created by Akashlal Bathe on 14/09/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation

@MainActor
final class ProductDetailVM: ObservableObject {
    
    var coordinator: Coordinator?
    var service: (any NetworkServiceable)?
    
    @Published private(set) var product: Product
    @Published private(set) var isLoading: Bool = true
    
    init(coordinator: Coordinator?, service: (any NetworkServiceable) = ProductDetailService(), product: Product) {
        self.coordinator = coordinator
        self.service = service
        self.product = product
    }
    
    func fetchDescriptionforProduct(with product: Product?) {
        if let product = product {
            self.product = product
        }
        
        guard let service else {
            Logger.sharedInstance.log(
                message: "Service not initialized [\(#file.components(separatedBy: "/").last ?? "") - Line \(#line)]",
                logLevel: .error
            )
            return
        }
        
        guard let request = TargetAPI.productDetail(id: self.product.id).request else {
            Logger.sharedInstance.log(
                message: "URLRequest not available [\(#file.components(separatedBy: "/").last ?? "") - Line \(#line)]",
                logLevel: .error
            )
            return
        }
        
        Task {
            do {
                guard let (product, response) = try await service.fetch(request: request) as? (Product, URLResponse) else {
                    Logger.sharedInstance.log(message: "Unable to find avail product, response")
                    return
                }
                Logger.sharedInstance.log(key: UUID().uuidString, message: "Product \(product.id) loaded", logLevel: .info)
                
                self.product = product
                self.isLoading = false
                
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
