//
//  AppFlowStarter.swift
//  ProductViewer
//
//  Created by Akashlal Bathe on 14/09/24.
//  Copyright © 2024 Target. All rights reserved.
//  Manages the flow of app and sets right coordinators

import UIKit

final class AppFlowStarter {
    
    // Different Flows for sequence of pages
    enum FlowPath {
        case productDiscovery
    }
    
    private init() {}
    
    static let shared = AppFlowStarter()
    
    @MainActor 
    func setup(
        path: FlowPath,
        with rootCoordinator: inout Coordinator?,
        in window: UIWindow?
    ) {
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        
        let coordinator: Coordinator?
        
        switch path{
        case .productDiscovery:
            coordinator = ProductsDiscoveryCoordinator(
                childCoordinators: [],
                navigationController: navigationController
            )
        }
        
        coordinator?.start()
        
    }
}

