//
//  ExploreView.swift
//  Lootz
//
//  Created by meshal on 9/17/25.
//

import SwiftUI
import SwiftData

struct ExploreView: View {
    @EnvironmentObject var viewModel: GiveawaysViewModel
    @Query var userQuery: [User]
    private var user: User? {
        userQuery.first
    }
    
    private let platforms = Platform.allCases.filter { $0 != .all }
    private var featuredGiveaways: [Giveaway] {
        Array(viewModel.giveaways.suffix(3))
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(featuredGiveaways) { giveaway in
                            GiveawayCardView(giveaway: giveaway, showLikeButton: false)
                                .frame(width: 350)
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .safeAreaPadding(.horizontal)
                .padding(.vertical)
                
                
                ForEach(platforms) { platform in
                    ExploreSection(platform: platform)
                }
            }
        }
        .navigationTitle("Explore")
        .toolbar {
            ToolbarItem(placement: .principal) {
                LogoView()
            }
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: ProfileView()) {
                    AvatarView(avatar: user?.avatar, size: 40, strokeWidth: 2)
                }
            }
            .sharedBackgroundVisibility(.hidden)
        }
    }
    
}

struct ItemView: View {
    let title: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.blue.gradient)
            .frame(height: 80)
            .overlay {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
            }
    }
}

#Preview(traits: .userMockData) {
    ContentView(activeTab: .explore)
}
