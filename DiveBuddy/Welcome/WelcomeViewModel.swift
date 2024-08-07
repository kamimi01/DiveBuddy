//
//  WelcomeViewModel.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-06.
//

import Foundation

final class WelcomeViewModel: ObservableObject {
    @Published var isPresentedRegisterView = false
    @Published var isPresentedLoginView = false

    func didTapRegisterButton() {
        isPresentedRegisterView = true
    }

    func didTapLoginButton() {
        isPresentedLoginView = true
    }
}
