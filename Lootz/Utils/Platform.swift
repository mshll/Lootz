//
//  Platform.swift
//  Lootz
//
//  Created by meshal on 9/16/25.
//

import Foundation

enum Platform: String, CaseIterable, Identifiable, CustomStringConvertible {
    case all, pc, steam, ios, android
    
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
