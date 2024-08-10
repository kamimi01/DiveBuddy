//
//  FirebaseAuthService.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-09.
//

import Foundation
import FirebaseAuth

struct FirebaseAuthService {
    func signup(email: String, password: String) async throws -> AuthDataResult {
        return try await Auth.auth().createUser(withEmail: email, password: password)
    }
}
