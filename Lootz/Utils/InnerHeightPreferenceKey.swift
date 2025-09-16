//
//  InnerHeightPreferenceKey.swift
//  Lootz
//
//  Created by meshal on 9/16/25.
//

import Foundation
import SwiftUI

struct InnerHeightPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
