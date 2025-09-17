//
//  ExploreSection.swift
//  Lootz
//
//  Created by meshal on 9/17/25.
//

import SwiftUI

struct ExploreSection: View {
    @EnvironmentObject var viewModel: GiveawaysViewModel
    
    var platform: Platform
    
    private var giveaways: [Giveaway] {
        filterGiveaways(viewModel.giveaways, byPlatform: platform)
    }
    
    private var chunkedGiveaways: [[Giveaway]] {
        giveaways.chunked(into: 3)
    }
    
        var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            
            NavigationLink(destination:
                            GiveawayListView(giveaways: viewModel.giveaways, selectedPlatform: platform, showFilters: false).navigationTitle(platform.description)
            ) {
                HStack {
                    Text("\(platform.description) Giveaways")
                        .font(Font.title2.bold())
                    Image(systemName: "chevron.right")
                        .foregroundColor(.primary.opacity(0.5))
                        .font(.system(size: 16, weight: .semibold))
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<chunkedGiveaways.count, id: \.self) { columnIndex in
                        VStack(alignment: .leading,spacing: 12) {
                            ForEach(chunkedGiveaways[columnIndex], id: \.self) { giveaway in
                                GiveawayCellView(giveaway: giveaway)
                            }
                            .frame(width: 300, height: 80)
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
        
        }
        .safeAreaPadding(.horizontal)
        .padding(.bottom)
        
    }
}

#Preview(traits: .userMockData) {
    ContentView(activeTab: .explore)
}
