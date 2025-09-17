//
//  FilterButton.swift
//  Lootz
//
//  Created by meshal on 9/16/25.
//

import SwiftUI

public struct FilterButton<T>: View where T: CustomStringConvertible & Equatable {
    @Binding var filterType: T
    var type: T
    
    private var isSelected: Bool {
        filterType == type
    }
    
    public var body: some View {
        Button {
            filterType = type
        } label: {
            Text(type.description)
                .font(.caption)
                .bold()
                .foregroundColor(isSelected ? Color(.inverse) : Color(.systemGray))
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(isSelected ? Color.primary : Color(.systemGray6), ignoresSafeAreaEdges: .horizontal)
                .clipShape(.capsule)
        }
        
    }
}

#Preview(traits: .userMockData) {
    ContentView()
}
