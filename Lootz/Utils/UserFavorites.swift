//
//  UserFavorites.swift
//  Lootz
//
//  Created by meshal on 9/17/25.
//

import SwiftData
import SwiftUI
import Foundation

extension View {
    
    func toggleFavorite(_ giveaway: Giveaway, _ modelContext: ModelContext) {
        let descriptor = FetchDescriptor<User>()
        
        do {
            let users = try modelContext.fetch(descriptor)
            guard let user = users.first else {
                print("No user found in context")
                return
            }
            
            if user.favoriteItems.contains(where: { $0.id == giveaway.id }) {
                // Remove from favorites
                user.favoriteItems.removeAll { $0.id == giveaway.id }
            } else {
                // Add to favorites
                user.favoriteItems.append(giveaway)
            }
            
            try modelContext.save()
        } catch {
            print("Error toggling favorite: \(error)")
        }
    }
    
    func isFavorited(_ giveaway: Giveaway, _ modelContext: ModelContext) -> Bool {
        let descriptor = FetchDescriptor<User>()
        
        do {
            let users = try modelContext.fetch(descriptor)
            guard let user = users.first else {
                return false
            }
            
            return user.favoriteItems.contains { $0.id == giveaway.id }
        } catch {
            print("Error checking favorite status: \(error)")
            return false
        }
    }
}
