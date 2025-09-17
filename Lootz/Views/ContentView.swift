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
    @State var activeTab: Tabs = .home
    @State private var searchText: String = ""
    @StateObject private var viewModel = GiveawaysViewModel()
    
    @Query var userQuery: [User]
        private var user: User? {
            userQuery.first
        }
    
    var body: some View {
        if user != nil {
            TabView(selection: $activeTab) {
                Tab("Home", systemImage: "gamecontroller.fill", value: Tabs.home) {
                    NavigationStack {
                        HomeView()
                    }
                }
                
                Tab("Explore", systemImage: "circle.grid.cross.fill", value: Tabs.explore) {
                    NavigationStack {
                        HomeView()
                    }
                }
                
                
                Tab(value: Tabs.search, role: .search) {
                    NavigationStack {
                        SearchView(query: searchText)
                    }
                    
                }
                
            }
            .tabBarMinimizeBehavior(.onScrollDown)
            .searchable(text: $searchText, placement: .toolbar, prompt: "Search games by name")
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
}
