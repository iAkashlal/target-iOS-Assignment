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
        productsListView.viewModel = dealsVM
        
        if let navigationController = navigationController {
            navigationController.setViewControllers(
                [productsListView],
                animated: true
            )
        }
        
    }
    
    func showDetails(for product: Product) {
        let productDescriptionVM = ProductDetailVM(coordinator: self)
        productDescriptionVM.fetchDescriptionforProduct(with: product.id)
        
        let productDetailVC = ProductDetailVC()
        
        if let navigationController = navigationController {
            navigationController.pushViewController(productDetailVC, animated: true)
        }
        
    }
    
    
}

