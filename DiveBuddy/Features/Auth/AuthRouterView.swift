//
//  AuthRouterView.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-10.
//

import SwiftUI

struct AuthRouterView: View {
    @EnvironmentObject var authManager: AuthManager

    var body: some View {
        if authManager.authState != .loggedOut {
            TabBarView()
                .environmentObject(authManager)
        } else {
            WelcomeView()
        }
    }
}

#Preview {
    AuthRouterView()
}
