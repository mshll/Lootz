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

  private var filteredGiveaways: [Giveaway] {
    if selectedPlatform == .all {
      return giveaways
    } else {
      return giveaways.filter {
        $0.platforms.localizedCaseInsensitiveContains(selectedPlatform.rawValue)
      }
    }
  }

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

          Section {
            ForEach(filteredGiveaways) { giveaway in
              GiveawayCardView(giveaway: giveaway)
            }
          }
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
