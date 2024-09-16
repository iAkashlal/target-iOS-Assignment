//
//  ProductDescriptionView.swift
//  ProductViewer
//
//  Created by Akashlal Bathe on 16/09/24.
//  Copyright © 2024 Target. All rights reserved.
//

import SwiftUI

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
    ProductDescriptionView(product: Product.mockProduct())
}
