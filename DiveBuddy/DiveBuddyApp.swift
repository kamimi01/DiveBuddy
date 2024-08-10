//
//  DiveBuddyApp.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-03.
//

import SwiftUI
import FirebaseCore

@main
struct DiveBuddyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authManager: AuthManager

    init() {
        FirebaseApp.configure()

        let authManager = AuthManager()
        _authManager = StateObject(wrappedValue: authManager)
    }

    var body: some Scene {
        WindowGroup {
            AuthRouterView()
                .environmentObject(authManager)
        }
    }
}
