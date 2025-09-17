//
//  AvatarView.swift
//  Lootz
//
//  Created by meshal on 9/16/25.
//

import SwiftUI

struct AvatarView: View {
    var avatar: Avatar?
    var size: CGFloat = 250
    var strokeWidth: CGFloat = 6
    
    var body: some View {
        Image(avatar?.rawValue ?? Avatar.avatar1.rawValue)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color(.systemGray6), lineWidth: strokeWidth)
            )
    }
}
