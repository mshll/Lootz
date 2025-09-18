//
//  ProfileTab.swift
//  Lootz
//
//  Created by meshal on 9/17/25.
//

import Foundation

enum ProfileTab: Int, CaseIterable {
    case liked = 0
    case purchased = 1
    case saved = 2
    
    var label: String {
        switch self {
        case .liked: return "Liked"
        case .purchased: return "Purchased"
        case .saved: return "Saved"
        }
    }
    
    var icon: String {
        switch self {
        case .liked: return "heart"
        case .purchased: return "receipt"
        case .saved: return "bookmark"
        }
    }
}
