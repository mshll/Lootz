//
//  ProfileContentView.swift
//  Lootz
//
//  Created by meshal on 9/17/25.
//

import SwiftUI

struct ProfileContentView: View {
    let selectedTab: Int
    let user: User?
    
    var body: some View {
        switch ProfileTab(rawValue: selectedTab) {
        case .liked:
            if let favs = user?.favoriteItems, !favs.isEmpty {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 8) {
                    ForEach(favs) { giveaway in
                        NavigationLink(destination: GiveawayDetailView(giveaway: giveaway)) {
                            GiveawayGridItemView(giveaway: giveaway)
                        }
                    }
                }
                .padding(.horizontal)
            } else {
                EmptyStateView(
                    icon: "heart",
                    title: "No Liked Items",
                    message: "Items you like will appear here"
                )
            }
            
        case .purchased:
            EmptyStateView(
                icon: "receipt",
                title: "No Purchases",
                message: "Your purchased items will appear here"
            )
        case .saved:
            EmptyStateView(
                icon: "bookmark",
                title: "No Saved Items",
                message: "Your saved items will appear here"
            )
        case .none:
            EmptyView()
        }
    }
}
