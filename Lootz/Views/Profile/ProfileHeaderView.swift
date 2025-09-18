//
//  ProfileHeaderView.swift
//  Lootz
//
//  Created by meshal on 9/17/25.
//

import SwiftUI

struct ProfileHeaderView: View {
    let user: User?
    let username: String
    
    var body: some View {
        VStack {
            AvatarView(avatar: user?.avatar, size: 150)
            
            Text(username)
                .font(.title.bold())
                .fontDesign(.rounded)
            
            Text("\(username.lowercased())@bankboubyan.com")
                .font(.caption)
                .foregroundStyle(Color(.secondaryLabel))
        }
        .padding(.bottom)
    }
}
