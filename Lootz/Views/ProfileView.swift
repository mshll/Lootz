//
//  ProfileView.swift
//  Lootz
//
//  Created by meshal on 9/16/25.
//

import SwiftUI
import SwiftData

struct ProfileView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var userQuery: [User]
    private var user: User? {
        userQuery.first
    }
    
    private var username : String {
        user?.username ?? "user"
    }
    
    @State private var selectedTab = 0
    private var profileTabs = [(label: "Liked", icon: "heart"),
                               ("Purchased", "receipt"),
                               ("Saved", "bookmark")]
    
    
    var body: some View {
        ScrollView {
            
            ProfileHeaderView
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], pinnedViews: .sectionHeaders) {
                Section {
                    // Your tab content (e.g., post grid)
                    ForEach(0..<100) { item in
                        Rectangle()
                            .fill(Color.blue)
                            .frame(height: 100)
                    }
                } header: {
                    ProfileTabsHeaderView
                }
            }
            
            
        }
        .scrollEdgeEffectStyle(.hard, for: .top)
        .toolbar {
            ToolbarItem(placement: .principal) {
                LogoView()
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Logout", systemImage: "rectangle.portrait.and.arrow.right", role: .destructive, action: {
                    if let user {
                        modelContext.delete(user)
                    }
                })
                    .labelStyle(.iconOnly)
                    .tint(.red)
                    .buttonStyle(.borderedProminent)
            }
        }
    }
    
    var ProfileHeaderView: some View {
        VStack {
            AvatarView(avatar: user?.avatar, size: 150)
            
            Text(username)
                .font(Font.title.bold())
                .fontDesign(.rounded)
            
            Text("\(username.lowercased())@bankboubyan.com")
                .font(Font.caption)
                .foregroundStyle(Color(.secondaryLabel))
        }
    }
    
    var ProfileTabsHeaderView: some View {
        HStack {
            ForEach(0..<profileTabs.count, id: \.self) { index in
                Button {
                    selectedTab = index
                } label: {
                    Image(systemName: profileTabs[index].1)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(selectedTab == index ? .accent : Color(.systemGray4))
                        .symbolVariant(selectedTab == index ? .fill : .none)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
//        .glassEffect(.clear, in: .rect)
    }
}

#Preview(traits: .userMockData) {
    NavigationStack {
        ProfileView()
    }
}
