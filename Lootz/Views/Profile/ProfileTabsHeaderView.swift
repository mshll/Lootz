//
//  ProfileTabsHeaderView.swift
//  Lootz
//
//  Created by meshal on 9/17/25.
//

import SwiftUI

struct ProfileTabsHeaderView: View {
    @Binding var selectedTab: Int
    let tabs: [ProfileTab]
    
    var body: some View {
        HStack {
            ForEach(tabs, id: \.rawValue) { tab in
                Button {
                    selectedTab = tab.rawValue
                } label: {
                    Image(systemName: tab.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(selectedTab == tab.rawValue ? .accent : Color(.systemGray4))
                        .symbolVariant(selectedTab == tab.rawValue ? .fill : .none)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .background(Color(.systemBackground))
    }
}
