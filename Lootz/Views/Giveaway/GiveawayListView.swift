//
//  GiveawayListView.swift
//  Lootz
//
//  Created by meshal on 9/16/25.
//

import SwiftUI

struct GiveawayListView: View {
    @EnvironmentObject var viewModel: GiveawaysViewModel
    let giveaways: [Giveaway]
    
    @State var selectedPlatform: Platform = .all
    var viewType: GiveawayViewType = .cell
    
    private var filteredGiveaways: [Giveaway] {
        filterGiveaways(giveaways, byPlatform: selectedPlatform)
    }
    
    var showFilters: Bool = true
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView("Loading Giveaways...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let error = viewModel.errorMessage {
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                    Text("Error")
                        .font(.title)
                        .padding(.top)
                    Text(error)
                        .multilineTextAlignment(.center)
                        .padding()
                    Button("Retry") {
                        viewModel.loadGiveawaysAsync()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List {
                    if showFilters {
                        Section(
                            header: ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(Platform.allCases) { platform in
                                        FilterButton(filterType: $selectedPlatform, type: platform)
                                    }
                                }
                                .padding(.vertical, 8)
                            }
                        ) {}
                            .listRowInsets(EdgeInsets())
                            .safeAreaPadding(.horizontal)
                    }
                    
                    Section {
                        if !filteredGiveaways.isEmpty {
                            ForEach(filteredGiveaways) { giveaway in
                                if viewType == .cell {
                                    GiveawayCellView(giveaway: giveaway)
                                } else {
                                    GiveawayCardView(giveaway: giveaway)
                                }
                            }
                        } else {
                            EmptyStateView(
                                icon: "gamecontroller",
                                title: "No giveaways found",
                                message: "Try changing the filters or search term"
                            )
                        }
                    }
                    .listRowInsets(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .listRowSeparator(.hidden)
                }
                .listRowSeparator(.hidden)
                .listStyle(PlainListStyle())
                
            }
        }
        
    }
}

#Preview(traits: .userMockData) {
    ContentView()
}

