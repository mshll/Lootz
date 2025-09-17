//
//  GiveawayCardView.swift
//  Lootz
//
//  Created by meshal on 9/16/25.
//

import SwiftUI


struct GiveawayCardView: View {
    let giveaway: Giveaway
    
    var body: some View {
        NavigationLink(destination: GiveawayDetailView(giveaway: giveaway)) {
            HStack(spacing: 12) {
                AsyncImage(url: URL(string: giveaway.thumbnail)) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray.opacity(0.2)
                }
                .frame(width: 60, height: 60)
                .cornerRadius(8)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(giveaway.title)
                        .font(.headline)
                    Text(giveaway.platforms)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 4)
        }
    }
}

#Preview(traits: .userMockData) {
    HomeView()
}
