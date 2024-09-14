//
//  ProductsDiscoveryCoordinator.swift
//  ProductViewer
//
//  Created by Akashlal Bathe on 14/09/24.
//  Copyright © 2024 Target. All rights reserved.
//

import UIKit

class ProductsDiscoveryCoordinator: Coordinator {
    var childCoordinators: [any Coordinator]
    
    var navigationController: UINavigationController?
    
    init(
        childCoordinators: [any Coordinator] = [],
        navigationController: UINavigationController? = nil) {
            self.childCoordinators = childCoordinators
            self.navigationController = navigationController
        }
    
    func start() {
        
        var productsListView = StandaloneListViewController()
        
        if let navigationController = navigationController {
            navigationController.setViewControllers(
                [productsListView],
                animated: true
            )
        }
        
    }
    
    
}

