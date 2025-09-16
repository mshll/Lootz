//
//  LoginView.swift
//  Lootz
//
//  Created by meshal on 9/16/25.
//

import Foundation
import SwiftUI
import SwiftData

struct LoginView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var avatar: Avatar = .avatar1
    @State var isLoading: Bool = false
    
    @State private var showAvatarPickerSheet = false
    @State private var isSecured: Bool = true
    @FocusState private var pwdField: Field?
    
    @Query var userQuery: [User]
    private var user: User? {
        userQuery.first
    }
    
    var body: some View {
        VStack {
            
            Text("Lootz")
                .font(.title)
                .fontWeight(.black)
                .fontDesign(.serif)
                .italic()
                .padding()
            
            Spacer()
            
            Button {
                showAvatarPickerSheet = true
            } label: {
                Image(avatar.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color(.systemGray6), lineWidth: 6)
                    )
                    .overlay(alignment: .bottomTrailing) {
                        Image(systemName: "pencil")
                            .foregroundStyle(.white)
                            .padding(10)
                            .background(Color.accent)
                            .clipShape(Circle())
                            .padding()
                    }
            }
            .padding(.bottom, 40)
            
            VStack(alignment: .leading) {
                Text("Username")
                    .font(Font.headline)
                TextField("example", text: $username)
                    .textFieldStyle(.plain)
                    .autocapitalization(.none)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            VStack(alignment: .leading) {
                Text("Password")
                    .font(Font.headline)
                //                SecureField("•••••••", text: $password)
                //                    .textFieldStyle(.plain)
                //                    .autocapitalization(.none)
                //                    .padding(10)
                //                    .background(Color(.systemGray6))
                //                    .cornerRadius(10)
                ZStack(alignment: .trailing) {
                    Group {
                        SecureField("•••••••", text: $password)
                            .textContentType(.password)
                            .focused($pwdField, equals: .secure)
                            .opacity(isSecured ? 1 : 0)
                        TextField("•••••••", text: $password)
                            .textContentType(.password)
                            .focused($pwdField, equals: .plain)
                            .opacity(isSecured ? 0 : 1)
                    }
                    
                    Button(action: {
                        isSecured.toggle()
                        pwdField = isSecured ? .secure : .plain
                    }) {
                        Image(systemName: self.isSecured ? "eye.slash.fill" : "eye.fill")
                            .accentColor(.gray)
                    }
                }
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            Spacer()
            
            Button(action: login) {
                ZStack {
                    if isLoading {
                        ProgressView().tint(.white)
                    } else {
                        Text("Login")
                    }
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.accentColor)
                .cornerRadius(.infinity)
                .padding(.horizontal)
                .padding(.bottom)
            }
            
        }
        .sheet(isPresented: $showAvatarPickerSheet) {
            AvatarPickerSheet(selectedAvatar: $avatar)
        }
    }
    
    private func login() {
        //TODO
    }
}

#Preview(traits: .userMockData) {
    LoginView()
}
