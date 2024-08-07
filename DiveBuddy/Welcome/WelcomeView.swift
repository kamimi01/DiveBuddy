//
//  ContentView.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-03.
//

import SwiftUI

struct WelcomeView: View {
    @ObservedObject private var viewModel = WelcomeViewModel()

    var body: some View {
        ZStack {
            Color.accentBlue
                .ignoresSafeArea()
            VStack {
                Spacer()
                Image(.sampleIcon)
                Spacer()
                welcomeText()
                    .padding(.bottom, 30)
                authView()
                    .padding(.bottom, 50)
            }
            .padding(.horizontal, 20)
        }
    }
}

private extension WelcomeView {
    func welcomeText() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Welcome")
                .font(.customFont(size: .one, weight: .bold))
                .foregroundStyle(.primaryWhite)
            Text("Manage and customize your diving gear sets with ease for various conditions and seasons.")
                .font(.customFont(size: .two))
                .foregroundStyle(.primaryWhite)
        }
    }

    func authView() -> some View {
        VStack(spacing: 24) {
            signUpButton()
            loginButton()
            guestLoginButton()
        }
    }

    func signUpButton() -> some View {
        Button(action: {
            viewModel.didTapRegisterButton()
        }) {
            Text("Sign up")
                .font(.customFont(size: .three, weight: .bold))
                .foregroundStyle(.accentBlue)
                .padding(.vertical, 11)
                .frame(maxWidth: .infinity)
        }
        .roundedButton(.one)
        .fullScreenCover(isPresented: $viewModel.isPresentedRegisterView) {
            SignupView()
        }
    }

    func loginButton() -> some View {
        Button(action: {
            viewModel.didTapLoginButton()
        }) {
            Text("Log in")
                .font(.customFont(size: .three, weight: .bold))
                .foregroundStyle(.primaryWhite)
                .padding(.vertical, 11)
                .frame(maxWidth: .infinity)
        }
        .roundedButton(.two)
        .fullScreenCover(isPresented: $viewModel.isPresentedLoginView) {
            LoginView()
        }
    }

    func guestLoginButton() -> some View {
        Button(action: {}) {
            Text("Continue as Guest")
                .font(.customFont(size: .two, weight: .bold))
                .foregroundStyle(.primaryWhite)
        }
    }
}

#Preview {
    WelcomeView()
}
