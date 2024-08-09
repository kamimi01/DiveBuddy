//
//  SettingsViewModel.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-09.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    @Published var isPresentedWelcomeView = false

    func didTapLogoutButton() {
        isPresentedWelcomeView = true
    }
}
