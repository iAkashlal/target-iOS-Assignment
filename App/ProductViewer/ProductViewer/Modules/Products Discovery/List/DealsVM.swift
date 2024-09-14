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
    var service: DealsService
    
    init(coordinator: Coordinator?, service: DealsService = DealsService()) {
        self.coordinator = coordinator
        self.service = service
    }
    
    func fetchAllDeals() {
        
        Task {
            do {
                let adsf = try await service.fetch(request: TargetAPI.deals.request!)
                print(adsf)
            } catch let error {
                print(error.localizedDescription.description)
            }
        }
        
        
    }
    
}
