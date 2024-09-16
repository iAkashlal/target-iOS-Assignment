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
    
    @StateObject var viewModel: ProductDetailVM
    
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



#Preview {
    ProductDetailView(viewModel: ProductDetailVM(coordinator: nil, product: Product.mockProduct()))
}
