//
//  DealsVMTests.swift
//  ProductViewerTests
//
//  Created by Akashlal Bathe on 15/09/24.
//  Copyright © 2024 Target. All rights reserved.
//

import XCTest
import Combine

@testable import ProductViewer

// MARK: - Mock Classes
final class MockNetworkServiceable: NetworkService<DealsResponse> {
    var dealsResponse: DealsResponse?
    var error: Error?

    func fetch(request: URLRequest) async throws -> (Any, URLResponse) {
        if let error = error {
            throw error
        }
        return (dealsResponse ?? DealsResponse(products: []), URLResponse())
    }
}

final class MockCoordinator: ProductsDiscoveryCoordinator {
    var showDetailsCalled = false
    var productPassed: Product?

    override func showDetails(for product: Product) {
        showDetailsCalled = true
        productPassed = product
    }
}

// MARK: - Tests
final class DealsVMTests: XCTestCase {
    var viewModel: DealsVM!
    var mockService: MockNetworkServiceable!
    var mockCoordinator: MockCoordinator!
    var cancellables: Set<AnyCancellable> = []
    
    @MainActor
    override func setUpWithError() throws {
        mockService = MockNetworkServiceable()
        mockCoordinator = MockCoordinator()
        viewModel = DealsVM(coordinator: mockCoordinator, service: mockService)
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        mockCoordinator = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    func test_fetchAllDeals_Success() {
        let sampleProducts = [Product].init(repeating: Product.mockProduct(), count: 20)
        mockService.dealsResponse = DealsResponse(products: sampleProducts)
        
        let expectation = XCTestExpectation(description: "Products should be fetched in 1 second")
        
        viewModel
            .$products
            .dropFirst()
            .sink { products in
                XCTAssertEqual(products.count, sampleProducts.count)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchAllDeals()
        
        wait(for: [expectation], timeout: 4)
    }
    
    @MainActor 
    func test_showProductDetailsCalled_CoordinatorCalledSuccessfully() {
        let sampleProducts = [Product].init(repeating: Product.mockProduct(), count: 20)
        mockService.dealsResponse = DealsResponse(products: sampleProducts)
        
        let expectation = XCTestExpectation(description: "Products should be fetched in 1 second")
        
        viewModel
            .$products
            .dropFirst()
            .sink { products in
                XCTAssertEqual(products.count, sampleProducts.count)
                
                Task { @MainActor in
                    self.viewModel.showDetailsForProduct(at: 0)
                    guard let coordinator = self.viewModel.coordinator as? MockCoordinator else {
                        XCTFail("Coordinator not mocked")
                        return
                    }
                    XCTAssertTrue(coordinator.showDetailsCalled)
                    XCTAssertEqual(coordinator.productPassed, self.viewModel.getProduct(at: 0))
                    expectation.fulfill()
                    
                }
            }
            .store(in: &cancellables)
        
        viewModel.fetchAllDeals()        
        
        wait(for: [expectation], timeout: 1)

    }
    
    
}
