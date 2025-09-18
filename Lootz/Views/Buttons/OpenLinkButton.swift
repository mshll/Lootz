//
//  OpenLinkButton.swift
//  Lootz
//
//  Created by meshal on 9/17/25.
//

import SwiftUI

public struct OpenLinkButton: View {
    @Environment(\.openURL) var openURL
    private let label: String
    private let url: URL
    
    public init(url: URL, label: String) {
        self.url = url
        self.label = label
    }
    
    public var body: some View {
        Link(destination: url) {
            Text(label)
                .bold()
        }
        .contentShape(Rectangle())
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .background(.accent)
        .foregroundStyle(.inverse)
        .contentShape(Rectangle())
        .onTapGesture {
            openURL(url)
        }
    }
}
