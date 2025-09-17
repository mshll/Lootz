//
//  PreferenceKeys.swift
//  Lootz
//
//  Created by meshal on 9/17/25.
//

import SwiftUI

struct GiveawayUrlPreferenceKey: PreferenceKey {
    static var defaultValue: String? = nil
    
    static func reduce(value: inout String?, nextValue: () -> String?) {
        value = nextValue()
    }
}

extension View {
    func changeGiveawayUrlPreference(_ url: String?) -> some View {
        preference(key: GiveawayUrlPreferenceKey.self, value: url)
    }
    
}
