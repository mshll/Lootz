//
//  SearchView.swift
//  Lootz
//
//  Created by meshal on 9/16/25.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var viewModel: GiveawaysViewModel
    var query = ""
    
    private var filteredGiveaways: [Giveaway] {
        if query.isEmpty {
            return viewModel.giveaways
        } else {
            return viewModel.giveaways.filter {
                $0.title.localizedCaseInsensitiveContains(query)
            }
        }
    }
    
    var body: some View {
        GiveawayListView(giveaways: filteredGiveaways)
            .navigationTitle("Search")
    }
}

#Preview(traits: .userMockData) {
    ContentView()
}
