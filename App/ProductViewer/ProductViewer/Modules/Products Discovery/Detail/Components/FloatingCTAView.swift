//
//  FloatingCTAView.swift
//  ProductViewer
//
//  Created by Akashlal Bathe on 16/09/24.
//  Copyright © 2024 Target. All rights reserved.
//

import SwiftUI

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

#Preview {
    FloatingCTAView()
}
