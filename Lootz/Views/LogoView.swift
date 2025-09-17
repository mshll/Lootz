//
//  LogoView.swift
//  Lootz
//
//  Created by meshal on 9/16/25.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Text("Lootz")
            .font(.title)
            .fontWeight(.black)
            .fontDesign(.serif)
            .italic()
            .padding()
    }
}

#Preview {
    LogoView()
}
