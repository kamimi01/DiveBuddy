//
//  RoundedButtonStyle.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-06.
//

import SwiftUI

enum ButtonType {
    case one
    case two
}

struct RoundedButtonStyle: ButtonStyle {
    var buttonType: ButtonType = .one

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(fontColor())
            .background {
                backgroundView()
            }
    }
}

private extension RoundedButtonStyle {
    func backgroundView() -> some View {
        switch buttonType {
        case .one:
            return AnyView(RoundedRectangle(cornerRadius: 10)
                .fill(backgroundColor()))
        case .two:
            return AnyView(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.primaryWhite, lineWidth: 1.0))
        }
    }

    func fontColor() -> Color {
        switch buttonType {
        case .one: return .accentBlue
        case .two: return .primaryWhite
        }
    }

    func backgroundColor() -> Color {
        switch buttonType {
        case .one: return .primaryWhite
        case .two: return .accentBlue
        }
    }
}

#Preview {
    ZStack {
        Color.accentBlue
        Button("Register") {}
            .buttonStyle(RoundedButtonStyle(buttonType: .one))
    }
}

#Preview {
    ZStack {
        Color.primaryWhite
        Button("Register") {}
            .buttonStyle(RoundedButtonStyle(buttonType: .two))
    }
}
