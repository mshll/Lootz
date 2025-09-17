//
//  GlobalData.swift
//  Lootz
//
//  Created by meshal on 9/17/25.
//

import Foundation
import SwiftUI

@Observable
class GlobalData {
    static let shared = GlobalData() // Singleton
    var selectedUrl: URL? = nil

    private init() {}
}
