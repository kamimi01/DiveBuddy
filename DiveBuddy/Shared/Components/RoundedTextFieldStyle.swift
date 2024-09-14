//
//  RoundedTextFieldStyle.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-06.
//

import Foundation
import SwiftUI

struct RoundedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .autocapitalization(.none)
            .padding(10)
            .background(.secondaryBgGray)
            .cornerRadius(10)
            .tint(.accentBlue)
    }
}
