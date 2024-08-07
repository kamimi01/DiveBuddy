//
//  RoundedCardButtonStyle.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-07.
//

import SwiftUI

struct RoundedCardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.secondaryBgGray)
                    .shadow(radius: 2, x: 1, y:1)
            }
    }
}

#Preview {
    Button(action: {}) {
        Image(systemName: "plus")
            .resizable()
            .frame(width: 25, height: 25)
            .foregroundStyle(.gray)
            .roundedCardButtonFrame()
    }
    .roundedCardButton()
}
