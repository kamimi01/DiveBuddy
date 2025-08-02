//
//  View+.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-06.
//

import Foundation
import SwiftUI

extension View {
    // TextField
    func roundedTextField() -> some View {
        self.textFieldStyle(RoundedTextFieldStyle())
    }

    // Button
    func roundedButton(_ buttonType: ButtonType) -> some View {
        self.buttonStyle(RoundedButtonStyle(buttonType: buttonType))
    }

    func roundedCardButton(_ buttonType: CardButtonType) -> some View {
        self.buttonStyle(RoundedCardButtonStyle(buttonType: buttonType))
    }

    func roundedCardButtonFrame() -> some View {
        self.frame(height: 160)
            .frame(maxWidth: 150)
    }

    func fullScreenBackground(_ color: Color) -> some View {
        self.modifier(FullScreenBackgroundViewModifier(color: color))
    }
}
