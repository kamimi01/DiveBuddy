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
    case three
}

struct RoundedButtonStyle: ButtonStyle {
    var buttonType: ButtonType

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
        case .three:
            return AnyView(RoundedRectangle(cornerRadius: 10)
                .fill(backgroundColor()))
        }
    }

    func fontColor() -> Color {
        switch buttonType {
        case .one           : return .accentBlue
        case .two, .three   : return .primaryWhite
        }
    }

    func backgroundColor() -> Color {
        switch buttonType {
        case .one           : return .primaryWhite
        case .two, .three   : return .accentBlue
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
        Color.accentBlue
        Button("Register") {}
            .buttonStyle(RoundedButtonStyle(buttonType: .two))
    }
}

#Preview {
    ZStack {
        Color.primaryWhite
        Button("Register") {}
            .buttonStyle(RoundedButtonStyle(buttonType: .three))
    }
}
