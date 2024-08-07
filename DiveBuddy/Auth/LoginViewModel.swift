//
//  LoginViewModel.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-06.
//

import Foundation

final class LoginViewModel: ObservableObject {
    @Published var isPresentedSignupView = false
    @Published var isPresentedTabBarView = false
    @Published var emailInput = ""
    @Published var passwordInput = ""

    func didTapSignupButton() {
        isPresentedSignupView = true
    }

    func didTapLogInButton() {
        isPresentedTabBarView = true
    }
}
