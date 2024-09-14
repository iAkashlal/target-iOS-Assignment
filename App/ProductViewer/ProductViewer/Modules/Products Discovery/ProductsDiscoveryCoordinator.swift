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
        let dealsVM = DealsVM(coordinator: self)
        dealsVM.fetchAllDeals()
        
        let productsListView = StandaloneListViewController()
        
        if let navigationController = navigationController {
            navigationController.setViewControllers(
                [productsListView],
                animated: true
            )
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showProduct(with: 2)
        }
        
    }
    
    func showProduct(with id: Int) {
        let productDescriptionVM = ProductDetailVM(coordinator: self)
        productDescriptionVM.fetchDescriptionforProduct(with: id)
        
        let productDetailVC = ProductDetailVC()
        
        if let navigationController = navigationController {
            navigationController.pushViewController(productDetailVC, animated: true)
        }
    }
    
    
}

