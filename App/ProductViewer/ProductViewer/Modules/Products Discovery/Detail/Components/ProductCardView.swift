//
//  ProductCardView.swift
//  ProductViewer
//
//  Created by Akashlal Bathe on 16/09/24.
//  Copyright © 2024 Target. All rights reserved.
//

import SwiftUI

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

#Preview {
    ProductCardView(product: Product.mockProduct())
}
