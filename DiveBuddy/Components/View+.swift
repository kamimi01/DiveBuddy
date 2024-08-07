//
//  View+.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-06.
//

import Foundation
import SwiftUI

extension View {
    func roundedButton(_ buttonType: ButtonType = .one) -> some View {
        self.buttonStyle(RoundedButtonStyle(buttonType: buttonType))
    }

    func roundedTextField() -> some View {
        self.textFieldStyle(RoundedTextFieldStyle())
    }

    func roundedCardButton() -> some View {
        self.buttonStyle(RoundedCardButtonStyle())
    }

    func roundedCardButtonFrame() -> some View {
        self.frame(width: 150, height: 160)
    }
}
