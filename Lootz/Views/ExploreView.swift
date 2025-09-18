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
    
    let platforms = Platform.allCases.filter { $0 != .all }
    
    var body: some View {
        ScrollView(.vertical) {
//            VStack {
            ForEach(platforms) { platform in
                ExploreSection(platform: platform)
            }
//            }
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
