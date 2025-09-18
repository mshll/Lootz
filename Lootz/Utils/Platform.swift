//
//  Platform.swift
//  Lootz
//
//  Created by meshal on 9/16/25.
//

import Foundation

enum Platform: String, CaseIterable, Identifiable, CustomStringConvertible {
    case all, steam, playstation, xbox, ios, android, pc
    
    var id: String { rawValue }
    
    var description: String {
        switch self {
        case .pc:
            return "PC"
        case .ios:
            return "iOS"
        default:
            return rawValue.capitalized
        }
    }
}


func filterGiveaways(_ giveaways: [Giveaway], byPlatform platform: Platform) -> [Giveaway] {
    if platform == .all {
        return giveaways
    } else {
        return giveaways.filter {
            $0.platforms.localizedCaseInsensitiveContains(platform.rawValue)
        }
    }
}
