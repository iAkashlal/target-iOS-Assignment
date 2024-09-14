//
//  Coordinator.swift
//  ProductViewer
//
//  Created by Akashlal Bathe on 14/09/24.
//  Copyright © 2024 Target. All rights reserved.
//  Basic Coordinator Protocol to manage navigation

import UIKit

protocol Coordinator {
    var childCoordinators: [any Coordinator] {get set}
    var navigationController: UINavigationController? {get set}
    
    func start()    // Load up first ViewController that's needed to render the flow
    
    
}

