//
//  User.swift
//  Lootz
//
//  Created by meshal on 9/16/25.
//

import Foundation
import SwiftData

enum Avatar: String, CaseIterable, Identifiable, Codable {
    var id: String { self.rawValue }
    case avatar1
    case avatar2
    case avatar3
    case avatar4
}

@Model
class User: Identifiable {
    var id: UUID
    var username: String
    var avatar: Avatar
    var isLoggedin: Bool
    
    init(id: UUID = UUID(), username: String, avatar: Avatar) {
        self.id = id
        self.username = username
        self.avatar = avatar
        self.isLoggedin = false
    }
    
}
