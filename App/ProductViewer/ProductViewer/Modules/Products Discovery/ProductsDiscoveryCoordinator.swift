//
//  ProductsDiscoveryCoordinator.swift
//  ProductViewer
//
//  Created by Akashlal Bathe on 14/09/24.
//  Copyright © 2024 Target. All rights reserved.
//

import SwiftUI
import UIKit

@MainActor
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
        
        let productsListView = DealsVC()
        productsListView.viewModel = dealsVM
        
        if let navigationController = navigationController {
            navigationController.setViewControllers(
                [productsListView],
                animated: true
            )
        }
        
    }
    
    func showDetails(for product: Product) {
        let productDescriptionVM = ProductDetailVM(coordinator: self, product: product)
        productDescriptionVM.fetchDescriptionforProduct(with: product)
        
        let swiftUIDetailVC = ProductDetailView(viewModel: productDescriptionVM)
        
        if let navigationController = navigationController {
            navigationController.pushViewController(UIHostingController(rootView: swiftUIDetailVC), animated: true)
        }
        
    }
    
    
}

