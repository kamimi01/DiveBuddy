//
//  RoundedCardButtonStyle.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-07.
//

import SwiftUI

enum CardButtonType {
    case one
    case two
}

struct RoundedCardButtonStyle: ButtonStyle {
    var buttonType: CardButtonType = .one

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(backgroundColor())
                    .shadow(radius: 2, x: 1, y:1)
            }
    }
}

private extension RoundedCardButtonStyle {
    func backgroundColor() -> Color {
        switch buttonType {
        case .one:  return .secondaryBgGray
        case .two:  return .accentBlue
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
    .roundedCardButton(.one)
}

#Preview {
    Button(action: {}) {
        Image(systemName: "plus")
            .resizable()
            .frame(width: 25, height: 25)
            .foregroundStyle(.gray)
            .roundedCardButtonFrame()
    }
    .roundedCardButton(.two)
}
