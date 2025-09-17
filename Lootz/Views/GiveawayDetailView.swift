//
//  GiveawayDetailView.swift
//  Lootz
//
//  Created by meshal on 9/16/25.
//

import SwiftUI

struct GiveawayDetailView: View {
    let giveaway: Giveaway

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: giveaway.image)) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }

                Text(giveaway.description)
                    .font(.body)

                if !giveaway.instructions.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Instructions")
                            .font(.headline)
                        Text(giveaway.instructions)
                    }
                }

                if let url = URL(string: giveaway.openGiveawayUrl) {
                    Link("Open Giveaway", destination: url)
                        .buttonStyle(.borderedProminent)
                }
            }
            .padding()
        }
        .navigationTitle(giveaway.title)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Favorite", systemImage: "heart", action: {/*TODO*/})
                    .labelStyle(.iconOnly)
            }
        }
    }
}

#Preview(traits: .userMockData) {
    ContentView()
}
