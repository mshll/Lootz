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
    @Environment(\.modelContext) private var modelContext
    @State var username: String = ""
    @State var password: String = ""
    @State var avatar: Avatar = .avatar1
    @State var isLoading: Bool = false
    
    @State private var showAvatarPickerSheet = false
    @State private var isSecured: Bool = true
    @FocusState private var field: Field?
    
    @Query var userQuery: [User]
    private var user: User? {
        userQuery.first
    }
    
    var body: some View {
        ScrollView {
            VStack {
                
                LogoView()
                
                Spacer()
                
                Button {
                    showAvatarPickerSheet = true
                } label: {
                    AvatarView(avatar: avatar)
                        .overlay(alignment: .bottomTrailing) {
                            Image(systemName: "pencil")
                                .foregroundStyle(Color(.inverse))
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
                        .focused($field, equals: .user)
                        .submitLabel(.next)
                        .onSubmit {
                            field = isSecured ? .secure : .plain
                        }
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                VStack(alignment: .leading) {
                    Text("Password")
                        .font(Font.headline)
                    ZStack(alignment: .trailing) {
                        Group {
                            SecureField("•••••••", text: $password)
                                .textContentType(.password)
                                .focused($field, equals: .secure)
                                .opacity(isSecured ? 1 : 0)
                            TextField("•••••••", text: $password)
                                .textContentType(.password)
                                .focused($field, equals: .plain)
                                .opacity(isSecured ? 0 : 1)
                        }
                        .submitLabel(.go)
                        .onSubmit {
                            login()
                        }
                        Button(action: {
                            isSecured.toggle()
                            field = isSecured ? .secure : .plain
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
            }
            .padding(.horizontal, 10)
            .sheet(isPresented: $showAvatarPickerSheet) {
                AvatarPickerSheet(selectedAvatar: $avatar)
            }
        }
        .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
        .scrollDismissesKeyboard(.interactively)
        
        .safeAreaInset(edge: .bottom) {
            Button(action: login) {
                if isLoading {
                    ProgressView().tint(Color(.inverse))
                        .frame(maxWidth: .infinity)
                        .padding(10)
                    
                } else {
                    Text("Login")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding(10)
                }
            }
            .foregroundStyle(Color(.inverse))
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .padding(.horizontal)
        }
        .padding(.vertical, 10)
        .background(Color(.systemBackground))
    }
    
    
    private func login() {
        if username.isEmpty || password.isEmpty { return }
        
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isLoading = false
            modelContext.insert(User(username: username, avatar: avatar))
        }
        
    }
}

#Preview(traits: .userMockData) {
    LoginView()
}
