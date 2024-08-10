//
//  FirebaseAuthService.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-09.
//

import Foundation
import FirebaseAuth

struct FirebaseAuthService {
    private let firebaseAuth = Auth.auth()

    func currentUser() -> User? {
        return firebaseAuth.currentUser
    }

    func signup(email: String, password: String) async throws -> AuthDataResult {
        return try await firebaseAuth.createUser(withEmail: email, password: password)
    }

    func login(email: String, password: String) async throws -> AuthDataResult {
        return try await firebaseAuth.signIn(withEmail: email, password: password)
    }

    func logout() throws {
        return try firebaseAuth.signOut()
    }

    func guestLogin() async throws -> AuthDataResult {
        return try await firebaseAuth.signInAnonymously()
    }
}
