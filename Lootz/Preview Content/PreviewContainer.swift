//
//  PreviewContainer.swift
//  Lootz
//
//  Created by meshal on 9/16/25.
//

import SwiftData
import SwiftUI

struct UserMockData: PreviewModifier {
    
    static func makeSharedContext() async throws -> ModelContainer {
        let container = try ModelContainer(for: User.self, configurations: .init(isStoredInMemoryOnly: true))
//        User.mockData.forEach { container.mainContext.insert($0) }
        container.mainContext.insert(User.mockData)
        return container
    }

    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var userMockData: Self = .modifier(UserMockData())
}
