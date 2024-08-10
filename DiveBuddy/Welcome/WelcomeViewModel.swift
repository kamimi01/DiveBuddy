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
    @Published var isPresentedTabbarView = false
    @Published var errorMessage = ""
    @Published var isPresentedErrorAlert = false

    private let authService: FirebaseAuthService

    init() {
        authService = FirebaseAuthService()
    }

    func didTapRegisterButton() {
        isPresentedRegisterView = true
    }

    func didTapLoginButton() {
        isPresentedLoginView = true
    }

    func didTapGuestLoginButton() {
        Task {
            do {
                let authResult = try await authService.guestLogin()
                await MainActor.run {
                    isPresentedTabbarView = true
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
