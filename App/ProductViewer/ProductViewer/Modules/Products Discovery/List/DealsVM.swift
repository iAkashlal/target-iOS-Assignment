//
//  DealsVM.swift
//  ProductViewer
//
//  Created by Akashlal Bathe on 14/09/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation

final class DealsVM {
    
    var coordinator: Coordinator?
    var service: (any NetworkServiceable)?
    
    init(coordinator: Coordinator?, service: (any NetworkServiceable) = DealsService()) {
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
                let deals = try await service.fetch(request: request)
                Logger.sharedInstance.log(key: UUID().uuidString, message: "Deals loaded", logLevel: .info)
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
