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
    @State var showLogoutAlert: Bool = false
    
    private var user: User? {
        userQuery.first
    }
    
    private var username: String {
        user?.username ?? "user"
    }
    
    @State private var selectedTab = 0
    private let profileTabs = ProfileTab.allCases
    
    var body: some View {
        ScrollView {
            ProfileHeaderView(user: user, username: username)
            
            VStack(spacing: 5) {
                ProfileTabsHeaderView(selectedTab: $selectedTab, tabs: profileTabs)
                
                ProfileContentView(selectedTab: selectedTab, user: user)
            }
        }
        .scrollEdgeEffectStyle(.hard, for: .top)
        .toolbar {
            ToolbarItem(placement: .principal) {
                LogoView()
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Logout", systemImage: "rectangle.portrait.and.arrow.right", role: .destructive) {
                    showLogoutAlert = true
                }
                .labelStyle(.iconOnly)
                .tint(.red)
                .buttonStyle(.borderedProminent)
                .alert("Are you sure you want to logout?", isPresented: $showLogoutAlert) {
                    Button("Logout", role: .destructive) {
                        logout()
                    }
                    .keyboardShortcut(.defaultAction)
                }
            }
        }
    }
    
    private func logout() {
        if let user {
            modelContext.delete(user)
        }
    }
}

#Preview(traits: .userMockData) {
    ContentView()
}
