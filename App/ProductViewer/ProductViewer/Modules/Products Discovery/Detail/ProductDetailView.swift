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

struct ProductCardView: View {
    
    var product: Product
    
    var body: some View {
        VStack {
            WebImage(url: product.imageUrl?.asURL())
                .resizable()
                .scaledToFit()
                .frame(
                    width: UIScreen.main.bounds.width - 32,
                    height: UIScreen.main.bounds.width - 32)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.top, 16)
            
            HStack {
                Text(product.title)
                    .foregroundColor(UIColor.darkestBlack.asColor())
                    .fontWeight(.semibold)
                    .font(.title2)
                    .padding(.top, 28)
                Spacer()
            }
            
            HStack {
                if product.isDiscounted {
                    Text(product.salePrice?.displayString ?? "$NaN")
                        .foregroundColor(UIColor.targetRed.asColor())
                        .font(.title3)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.red)
                    
                    Text("reg. \(product.regularPrice?.displayString ?? "$NaN")")
                        .foregroundColor(UIColor.grayDarkest.asColor())
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.gray)
                } else {
                    Text(product.regularPrice?.displayString ?? "$NaN")
                        .foregroundColor(UIColor.targetRed.asColor())
                        .font(.title3)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                }
                Spacer()
            }
            .padding(.top, 11)
            
            HStack {
                Text(product.fulfillment)
                    .foregroundColor(UIColor.textLightGray.asColor())
                    .font(.footnote)
                    .padding(.top, 2)
                Spacer()
            }
            
        }
        .padding(.horizontal, 16)
    }
}

struct FloatingCTAView: View {
    var body: some View {
        VStack {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    
                    VStack {
                        Button(action: {
                            // Action for add to cart
                        }) {
                            Text("Add to cart")
                                .foregroundColor(.white)
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(UIColor.targetRed.asColor())
                                .cornerRadius(8)
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 30)
                        .padding(.top, 16)
                    }
                    .frame(width: geometry.size.width)
                    .background(Color.white)
                    .cornerRadius(8, corners: [.topLeft, .topRight])
                    .shadow(radius: 10)
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
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
