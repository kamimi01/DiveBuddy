//
//  SignupViewModel.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-07.
//

import Foundation

final class SignupViewModel: ObservableObject {
    @Published var isPresentedLoginView = false
    @Published var isPresentedTabBarView = false
    @Published var emailInput = ""
    @Published var passwordInput = ""

    func didTapLoginButton() {
        isPresentedLoginView = true
    }

    func didTapSignupButton() {
        isPresentedTabBarView = true
    }
}
