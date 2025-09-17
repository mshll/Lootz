//
//  HomeView.swift
//  Lootz
//
//  Created by meshal on 9/16/25.
//

import SwiftUI
import Moya
import SwiftData

struct HomeView: View {
    @EnvironmentObject var viewModel: GiveawaysViewModel
    
    @State private var selectedPlatform: Platform = .all
    
    @Query var userQuery: [User]
    private var user: User? {
        userQuery.first
    }
    
    
    var body: some View {
        GiveawayListView(giveaways: viewModel.giveaways, viewType: .card)
            .navigationTitle("Giveaways")
            .refreshable {
                viewModel.loadGiveawaysAsync()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    LogoView()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: ProfileView()) {
                        AvatarView(avatar: user?.avatar, size: 40, strokeWidth: 4)
                    }
                }
                .sharedBackgroundVisibility(.hidden)
            }
        
    }
}



#Preview(traits: .userMockData) {
    ContentView()
}
