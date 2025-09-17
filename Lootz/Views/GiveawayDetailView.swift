//
//  GiveawayDetailView.swift
//  Lootz
//
//  Created by meshal on 9/16/25.
//

import SwiftUI

struct GiveawayDetailView: View {
    let giveaway: Giveaway
    @State private var giveawayUrl: String?
    @State private var headerHeight: CGFloat = 200
    
    private var endDate: String {
        relativeTimeLeft(from: giveaway.endDate)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                GeometryReader { geometry in
                    let width = geometry.size.width
                    ZStack {
                        AsyncImage(url: URL(string: giveaway.image)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: headerHeight)
                                .clipped()
                        } placeholder: {
                            ZStack {
                                Color.gray.opacity(0.15)
                                ProgressView()
                            }
                            .frame(width: width, height: headerHeight)
                        }
                        VStack(alignment: .leading) {
                            Spacer()
                            HStack {
                                if !endDate.isEmpty {
                                    Text("Ends \(endDate)")
                                        .font(.caption)
                                        .padding(10)
                                        .fontWeight(.bold)
                                        .glassEffect()
                                    Spacer()
                                }
                            }
                        }
                        .padding()
                    }
                }
                .frame(height: headerHeight)
                .ignoresSafeArea(edges: .top)
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    Text(giveaway.title)
                        .font(.title.bold())
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 10)
                    
                    HStack(spacing: 12) {
                        Badge("Price", giveaway.worth)
                        Badge("Users", "\(giveaway.users)")
                        Badge("Type", giveaway.type)
                    }
                    
                    Section("Platforms", giveaway.platforms)
                    
                    Section("Description", giveaway.description)
                    
                    Section("Instructions", giveaway.instructions)
                    
//                    if let url = URL(string: giveaway.openGiveawayUrl) {
//                        Link(destination: url) {
//                            Text("Open Giveaway")
//                                .bold()
//                                .frame(maxWidth: .infinity)
//                                .padding(10)
//                        }
//                        .foregroundStyle(Color(.inverse))
//                        .buttonStyle(.borderedProminent)
//                        .buttonBorderShape(.capsule)
//                        .padding(.vertical, 40)
//                        
//                    }
                }
                .safeAreaPadding(.horizontal)
                .padding(.bottom)
            }
        }
        .ignoresSafeArea(edges: .top)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Favorite", systemImage: "heart", action: {/*TODO*/})
                    .labelStyle(.iconOnly)
            }
        }
        .tabBarMinimizeBehavior(.onScrollDown)
        
        .onAppear { giveawayUrl = giveaway.openGiveawayUrl }
        .onChange(of: giveaway) { giveawayUrl = giveaway.openGiveawayUrl }
        .onDisappear { giveawayUrl = nil }
        .changeGiveawayUrlPreference(giveawayUrl)
    }
    
    @ViewBuilder
    private func Badge(_ title: String, _ content: String?) -> some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.footnote.bold())
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
            Text(content ?? "N/A")
                .font(.title2)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding()
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
    
    @ViewBuilder
    private func Section(_ title: String, _ content: String) -> some View {
        if !content.isEmpty {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(content)
                    .font(.body)
            }
        }
    }
}

#Preview(traits: .userMockData) {
    ContentView()
}
