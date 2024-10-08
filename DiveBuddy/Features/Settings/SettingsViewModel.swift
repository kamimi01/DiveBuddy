//
//  SettingsViewModel.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-09.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    @Published var isPresentedWelcomeView = false
    @Published var isPresentedErrorAlert = false
    @Published var isPresentedLogoutConfirmAlert = false
    @Published var errorMessage = ""
    @Published var isPresentedSignupView = false

    private let authService: AuthManager

    init() {
        authService = AuthManager()
    }

    func didTapLogoutButton() {
        isPresentedLogoutConfirmAlert = true
    }

    func didTapLogoutYesButton() {
        Task {
            do {
                try self.authService.logout()
                await MainActor.run {
                    isPresentedWelcomeView = true
                }
            } catch {
                await MainActor.run {
                    errorMessage += error.localizedDescription
                    isPresentedErrorAlert = true
                }
            }
        }
    }

    func isAnonymous() -> Bool {
        return authService.authState == .authenticated
    }

    func didTapOKInErrorAlert() {
        errorMessage = ""
    }

    func didTapSingupButton() {
        isPresentedSignupView = true
    }
}
