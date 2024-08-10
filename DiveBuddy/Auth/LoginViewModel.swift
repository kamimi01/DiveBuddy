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
    @Published var isPresentedErrorAlert = false
    @Published var errorMessage = ""

    private let authService: FirebaseAuthService
    private let minNumOfPasword = 8

    init() {
        authService = FirebaseAuthService()
    }

    func didTapSignupButton() {
        isPresentedSignupView = true
    }

    func didTapLogInButton() {
        if !isValidUserInfo(email: emailInput, password: passwordInput) {
            isPresentedErrorAlert = true
            return
        }

        Task { [weak self] in
            guard let self else { return }

            do {
                let authResult = try await self.authService.login(email: emailInput, password: passwordInput)
                await MainActor.run {
                    self.isPresentedTabBarView = true
                }
            } catch {
                await MainActor.run {
                    self.errorMessage += error.localizedDescription
                    self.isPresentedErrorAlert = true
                }
            }
        }
    }

    func didTapOKInErrorAlert() {
        errorMessage = ""
    }

    /// FIXME: wanna delete this method cuz it's completely same as the one in SignupViewModel
    private func isValidUserInfo(email: String, password: String) -> Bool {
        if !isValidEmail(email) {
            errorMessage += String(localized: "Please enter a valid email address.") + "\n"
        }
        if !isValidPassword(password) {
            errorMessage += String(localized: "Please enter a password with at least \(minNumOfPasword) characters.")
        }
        return errorMessage.isEmpty
    }

    /// FIXME: wanna delete this method cuz it's completely same as the one in SignupViewModel
    private func isValidEmail(_ email: String) -> Bool {
        if email.isEmpty { return false }

        let emailPattern = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
        return emailPredicate.evaluate(with: email)
    }

    /// FIXME: wanna delete this method cuz it's completely same as the one in SignupViewModel
    private func isValidPassword(_ password: String) -> Bool {
        if password.isEmpty { return false }
        return password.count >= minNumOfPasword
    }
}
