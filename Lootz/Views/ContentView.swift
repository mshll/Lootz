//
//  ContentView.swift
//  Lootz
//
//  Created by meshal on 9/16/25.
//

import SwiftUI
import SwiftData

enum Tabs: Int {
    case home = 0, explore, search
}


struct ContentView: View {
    @Environment(\.openURL) var openURL
    @State var activeTab: Tabs = .home
    @State private var searchText: String = ""
    @StateObject private var viewModel = GiveawaysViewModel()
    @State private var giveawayUrl: String? = nil
    
    @Query var userQuery: [User]
    private var user: User? {
        userQuery.first
    }
    
    var body: some View {
        if user != nil {
            TabView(selection: $activeTab) {
                Tab("Giveaways", systemImage: "gamecontroller.fill", value: Tabs.home) {
                    NavigationStack {
                        HomeView()
                    }
                    .onPreferenceChange(GiveawayUrlPreferenceKey.self) { giveawayUrl = $0 }
                }
                
                Tab("Explore", systemImage: "circle.grid.cross.fill", value: Tabs.explore) {
                    NavigationStack {
                        ExploreView()
                    }
                    .onPreferenceChange(GiveawayUrlPreferenceKey.self) { giveawayUrl = $0 }
                }
                
                Tab(value: Tabs.search, role: .search) {
                    NavigationStack {
                        SearchView(query: searchText)
                            .searchable(text: $searchText, placement: .toolbar, prompt: "Search games by name")
                    }
                    .onPreferenceChange(GiveawayUrlPreferenceKey.self) { giveawayUrl = $0 }
                }
                
            }
            .tabViewBottomAccessory {
                if let giveawayUrl, let url = URL(string: giveawayUrl) {
                    OpenLinkButton(url: url, label: "Claim Giveaway")
                }
            }
            .tabBarMinimizeBehavior(.onScrollDown)
            .searchToolbarBehavior(.minimize)
            .environmentObject(viewModel)
            .onAppear {
                if viewModel.giveaways.isEmpty {
                    viewModel.loadGiveawaysAsync()
                }
            }

        } else {
            LoginView()
        }
    }
}


#Preview(traits: .userMockData) {
    ContentView()
//        .environment(GlobalData.shared)
}
