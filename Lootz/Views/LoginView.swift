//
//  LoginView.swift
//  Lootz
//
//  Created by meshal on 9/16/25.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var isLoading: Bool = false
    
    var body: some View {
        VStack {
            
            Text("Lootz")
                .font(.title)
                .fontWeight(.black)
                .fontDesign(.serif)
                .italic()
                .padding()
            
            Spacer()
            
            Image(.Avatars.avatar1)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .clipShape(Circle())
                .overlay(
                    Circle()
                    .stroke(Color(.systemGray6), lineWidth: 6)
                )
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
                SecureField("•••••••", text: $password)
                    .textFieldStyle(.plain)
                    .autocapitalization(.none)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            Spacer()
            
            Button(action: login) {
                if isLoading {
                    ProgressView()
                } else {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .cornerRadius(.infinity)
                        .padding(.horizontal)
                }
            }
            .padding(.bottom)
            
            
                
        }
    }
    
    private func login() {
        //TODO
    }
}

#Preview {
    LoginView()
}
