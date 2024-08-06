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
}
