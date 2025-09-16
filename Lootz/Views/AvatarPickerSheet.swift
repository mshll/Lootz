//
//  AvatarPickerSheet.swift
//  Lootz
//
//  Created by meshal on 9/16/25.
//

import SwiftUI

struct AvatarPickerSheet: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State private var sheetHeight: CGFloat = .zero
    @Environment(\.dismiss) private var dismiss
    
    @Binding var selectedAvatar: Avatar
    
    var body: some View {
        VStack {
            Text("Select an avatar")
                .font(.title3.bold())
            
            LazyVGrid(columns: columns) {
                ForEach(Avatar.allCases) { avatar in
                    Button {
                        selectedAvatar = avatar
                        dismiss()
                    } label: {
                        Image(avatar.rawValue)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color(.systemGray6), lineWidth: 4)
                            )
                            .padding()

                    }
                }
            }
        }
        .padding()
        .overlay {
            GeometryReader { geometry in
                Color.clear.preference(key: InnerHeightPreferenceKey.self, value: geometry.size.height)
            }
        }
        .onPreferenceChange(InnerHeightPreferenceKey.self) { newHeight in
            sheetHeight = newHeight
        }
        .presentationDetents([.height(sheetHeight)])
    }
}


#Preview {
    @Previewable @State var avatar: Avatar = .avatar1
    AvatarPickerSheet(selectedAvatar: $avatar)
}
