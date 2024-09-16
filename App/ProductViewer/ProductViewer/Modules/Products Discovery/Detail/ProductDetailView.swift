//
//  ProductDetail.swift
//  ProductViewer
//
//  Created by Akashlal Bathe on 15/09/24.
//  Copyright © 2024 Target. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductDetailView: View {
    
    @StateObject var viewModel: ProductDetailVM = ProductDetailVM(coordinator: nil, product: Product.mockProduct())
    
    var body: some View {
            ZStack {
                
                ScrollView {
                    VStack {
                        ProductCardView(product: viewModel.product)
                        
                        Rectangle()
                            .fill(UIColor.dividerBackground.asColor())
                            .frame(height: 16)
                            .frame(maxWidth: .infinity)
                            .overlay(
                                    VStack {
                                        Rectangle()
                                            .frame(height: 1)
                                            .foregroundColor(UIColor.thinBorderGray.asColor())
                                        Spacer()
                                        Rectangle()
                                            .frame(height: 1)
                                            .foregroundColor(UIColor.thinBorderGray.asColor())
                                    }
                                )

                        ProductDescriptionView(product: viewModel.product)
                        
                        Spacer()
                            .frame(height: 75)
                    }
                }
                
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                }
                
                FloatingCTAView()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Detail")
                        .font(.headline)
                }
            }
    }
}

struct ProductDescriptionView: View {
    var product: Product
    var body: some View {
        VStack {
            HStack {
                Text("Product details")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(UIColor.grayDarkest.asColor())
                    .padding(.vertical, 11)
                Spacer()
            }
            .padding(.vertical, 10)
            
            
            Text(product.description)
                .font(.body)
                .foregroundColor(UIColor.grayMedium.asColor())
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 10)
    }
}

#Preview {
    ProductDetailView()
}
