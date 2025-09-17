//
//  GiveawayCardView.swift
//  Lootz
//
//  Created by meshal on 9/17/25.
//

import SwiftUI


struct GiveawayCardView: View {
    let giveaway: Giveaway
    
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
                    gradient: Gradient(colors: [.accentColor, Color.clear]),
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
                        
                        Spacer()
                        
                        Button("Favorite", systemImage: "heart", action: {})
                            .labelStyle(.iconOnly)
                            .padding(10)
                            .glassEffect(.regular.interactive())
                            .clipShape(Circle())
                            .buttonStyle(BorderlessButtonStyle())
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
                    .padding(.trailing)
                }
                .padding()
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
