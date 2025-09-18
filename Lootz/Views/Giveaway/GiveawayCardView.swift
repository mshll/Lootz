//
//  GiveawayCardView.swift
//  Lootz
//
//  Created by meshal on 9/17/25.
//

import SwiftUI


struct GiveawayCardView: View {
    let giveaway: Giveaway
    @Environment(\.modelContext) private var ctx
    
    private var isFav: Bool {
        isFavorited(giveaway, ctx)
    }
    
    private var endDate: String {
        relativeTimeLeft(from: giveaway.endDate)
    }
    
    var body: some View {
        NavigationLink(destination: GiveawayDetailView(giveaway: giveaway)) {
            ZStack(alignment: .bottomLeading) {
                GeometryReader { geometry in
                    AsyncImage(url: URL(string: giveaway.thumbnail)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    } placeholder: {
                        Color.gray.opacity(0.2)
                    }
                    //                    .frame(maxWidth: geometry.size.width)
                    .frame(maxHeight: .infinity)
                }
                
                LinearGradient(
                    gradient: Gradient(colors: [.black, Color.clear]),
                    startPoint: .bottom, endPoint: .top
                )
                .frame(height: 150)
                .frame(maxWidth: .infinity, alignment: .bottom)
                
                Rectangle()
                    .fill(.regularMaterial)
                    .mask {
                        LinearGradient(colors: [.black, .clear], startPoint: .bottom, endPoint: .top)
                    }
                    .frame(height: 150)
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    HStack {
                        Text(giveaway.type)
                            .font(.caption2)
                            .fontWeight(.semibold)
                            .padding(10)
                            .glassEffect()
                        
                        if !endDate.isEmpty {
                            Text("Ends \(endDate)")
                                .font(.caption2)
                                .padding(10)
                                .fontWeight(.semibold)
                                .glassEffect(.regular.tint(getDateTint(endDate)))
                        }
                        
                        Spacer()
                        
                        Button("Favorite", systemImage: isFav ? "heart.fill" : "heart", action: {
                            toggleFavorite(giveaway, ctx)
                        })
                        .labelStyle(.iconOnly)
                        .padding(10)
                        .glassEffect(.regular.interactive())
                        .foregroundStyle(isFav ? .red : .primary)
                        .clipShape(Circle())
                        .contentShape(Rectangle())
                        .buttonStyle(.plain)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(giveaway.title)
                            .font(.title3.bold())
                            .foregroundColor(.white)
                            .shadow(radius: 2)
                        Text(giveaway.platforms)
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.85))
                    }
                    .padding(10)
                    .padding(.trailing)
                }
                .padding(10)
            }
            .frame(height: 250)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
        .navigationLinkIndicatorVisibility(.hidden)
    }
}

#Preview(traits: .userMockData) {
    ContentView()
}
