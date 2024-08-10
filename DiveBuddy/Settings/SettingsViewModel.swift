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
    @Published var errorMessage = ""

    private let authService: FirebaseAuthService

    init() {
        authService = FirebaseAuthService()
    }

    func didTapLogoutButton() {
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

    func didTapOKInErrorAlert() {
        errorMessage = ""
    }
}
