//
//  Giveaway.swift
//  Lootz
//
//  Created by meshal on 9/16/25.
//

import Foundation

struct Giveaway: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let worth: String?
    let thumbnail: String
    let image: String
    let description: String
    let instructions: String
    let openGiveawayUrl: String
    let publishedDate: String
    let type: String
    let platforms: String
    let endDate: String?
    let users: Int
    let status: String
    let gamerpowerUrl: String
    let openGiveaway: String

}
