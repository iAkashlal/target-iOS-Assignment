//
//  DealsVM.swift
//  ProductViewer
//
//  Created by Akashlal Bathe on 14/09/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Combine
import Foundation

final class DealsVM: ObservableObject {
    
    var coordinator: Coordinator?
    var service: NetworkService<DealsResponse>?
    
    @Published
    private(set) var products: [Product] = []
    
    init(coordinator: Coordinator?, service: NetworkService<DealsResponse> = DealsService()) {
        self.coordinator = coordinator
        self.service = service
    }
    
    func fetchAllDeals() {
        guard let service else {
            Logger.sharedInstance.log(
                message: "Service not initialized [\(#file.components(separatedBy: "/").last ?? "") - Line \(#line)]",
                logLevel: .error
            )
            return
        }
        
        guard let request = TargetAPI.deals.request else {
            Logger.sharedInstance.log(
                message: "URLRequest not available [\(#file.components(separatedBy: "/").last ?? "") - Line \(#line)]",
                logLevel: .error
            )
            return
        }
        
        Task {
            do {
                let (deals, response) = try await service.fetch(request: request)
                Logger.sharedInstance.log(key: UUID().uuidString, message: "Deals loaded", logLevel: .info)
                
                self.products = deals.products
                
            } catch let error {
                Logger.sharedInstance.log(
                    key: UUID().uuidString,
                    message: error.localizedDescription + "[\(#file.components(separatedBy: "/").last ?? "") - Line \(#line)]",
                    logLevel: .error
                )
                print(error.localizedDescription.description)
            }
        }
        
    }
    
    
}

// MARK: - Helper functions for UICollectionView
extension DealsVM {
    
    func numberOfProducts() -> Int {
        return self.products.count
    }
    
    func getProduct(at index: Int) -> Product? {
        guard index < products.count else {
            Logger.sharedInstance.log(message: "DealsVC trying to display more items than it has")
            return nil
        }
        
        return products[index]
    }
    
    func getPageTitle() -> String {
        return "List"
    }
}

extension DealsVM {
    @MainActor 
    func showDetailsForProduct(at index: Int) {
        let product = getProduct(at: index)
        guard let product = getProduct(at: index),
              let coordinator = self.coordinator as? ProductsDiscoveryCoordinator else{
            return
        }
        coordinator.showDetails(for: product)
    }
}
