//
//  SnapperView.swift
//  Lootz
//
//  Created by meshal on 9/18/25.
//
// src: https://medium.com/@pdgna44/snapping-carousel-in-swiftui-ios-16-9fb1de8cdf69

import SwiftUI

struct SnapperView: View {
    let size: CGSize // passed in from GeometryReader
    private let padding: CGFloat
    private let cardWidth: CGFloat
    private let spacing: CGFloat = 15.0 // spacing between cards
    
    init(size: CGSize) {
        self.size = size
        // card width is 0.85 % of the screen width
        self.cardWidth = size.width * 0.85
        
        // screen width - card Width divided by 2 to center the first card
        self.padding = (size.width - cardWidth) / 2.0
    }
    
    var body: some View {
        LazyHStack(spacing: spacing) {
            ZStack() {
                Rectangle()
                    .foregroundColor(Color.red)
                    .cornerRadius(20)
                Text("😝")
                    .font(.system(size: 200, weight: .bold))
            }
            .frame(width: cardWidth)
        }
        .padding(.horizontal, padding)
    }
}
