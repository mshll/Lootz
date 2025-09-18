//
//  GiveawayGridItemView.swift
//  Lootz
//
//  Created by meshal on 9/17/25.
//

import SwiftUI

struct GiveawayGridItemView: View {
    let giveaway: Giveaway
    
    var body: some View {
        AsyncImage(url: URL(string: giveaway.image)) { image in
            image
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .clipped()
        } placeholder: {
            ZStack {
                Color.gray.opacity(0.15)
                ProgressView()
            }
            .aspectRatio(1, contentMode: .fill)
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
