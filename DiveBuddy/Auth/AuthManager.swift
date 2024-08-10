//
//  AuthManager.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-10.
//

import Foundation
import FirebaseAuth

enum AuthState {
    /// Anonymously authenticated in Firebase.
    case authenticated
    /// Authenticated in Firebase using one of service providers, and not anonymous.
    case loggedIn
    /// Not authenticated in Firebase.
    case loggedOut
}

final class AuthManager: ObservableObject {
    @Published var user: User?
    @Published var authState = AuthState.loggedOut

    private var authStateHandle: AuthStateDidChangeListenerHandle!

    init() {
        configureAuthStateChanges()
    }

    func configureAuthStateChanges() {
        authStateHandle = Auth.auth().addStateDidChangeListener { auth, user in
            print("Auth changed:", user != nil)
            self.updateState(user: user)
        }
    }

    func updateState(user: User?) {
        self.user = user
        print("uid:", user?.uid)
        let isAuthenticatedUser = user != nil
        let isAnonymous = user?.isAnonymous ?? false

        if isAuthenticatedUser {
            authState = isAnonymous ? .authenticated : .loggedIn
        } else {
            authState = .loggedOut
        }
    }
}
