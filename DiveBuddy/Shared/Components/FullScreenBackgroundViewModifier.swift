//
//  FullScreenBackgroundViewModifier.swift
//  DiveBuddy
//
//  Created by mika_admin on 2025-08-02.
//

import SwiftUI

struct FullScreenBackgroundViewModifier: ViewModifier {
    let color: Color

    init(color: Color) {
        self.color = color
    }

    func body(content: Content) -> some View {
        ZStack {
            color.ignoresSafeArea()
            content
        }
    }
}

#Preview {
    Text("Test")
        .fullScreenBackground(.accentBlue)
}
