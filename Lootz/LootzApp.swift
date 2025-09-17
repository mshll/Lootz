//
//  LootzApp.swift
//  Lootz
//
//  Created by meshal on 9/16/25.
//

import SwiftUI
import SwiftData

@main
struct LootzApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }

}
