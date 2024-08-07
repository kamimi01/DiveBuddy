//
//  LoginView.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-06.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject private var viewModel = LoginViewModel()

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 40) {
                emailPassInput()
                    .padding(.top, 20)
                logInButton()
                Spacer()
                thirdPartyLoginView()
            }
            .padding(.horizontal, 20)
            .navigationTitle("Log in")
        }
    }
}

private extension LoginView {
    func emailPassInput() -> some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Your email")
                    .font(.customFont(size: .three))
                TextField("", text: $viewModel.emailInput)
                    .roundedTextField()
            }
            VStack(alignment: .leading, spacing: 6) {
                Text("Password")
                    .font(.customFont(size: .three))
                ZStack {
                    TextField("", text: $viewModel.passwordInput)
                        .roundedTextField()
                    HStack {
                        Spacer()
                        Button(action: {}) {
                            Image(.closedEye)
                        }
                        .padding(.trailing, 10)
                    }
                }
            }
        }
    }

    func logInButton() -> some View {
        VStack(spacing: 14) {
            Button(action: {}) {
                Text("Log in")
                    .font(.customFont(size: .three))
                    .foregroundStyle(.primaryWhite)
                    .padding(.vertical, 11)
                    .frame(maxWidth: .infinity)
            }
            .roundedButton(.three)
            HStack(spacing: 20) {
                Text("Don't have account?")
                    .font(.customFont(size: .two))
                    .foregroundStyle(.primaryTextBlack)
                Button(action: {
                    viewModel.didTapSignupButton()
                }) {
                    Text("Sign up")
                        .font(.customFont(size: .two, weight: .bold))
                        .foregroundStyle(.accentBlue)
                }
                .fullScreenCover(isPresented: $viewModel.isPresentedSignupView) {
                    SignupView()
                }
            }
        }
    }

    func thirdPartyLoginView() -> some View {
        VStack(spacing: 20) {
            Text("Or log in with")
                .font(.customFont(size: .three))
                .foregroundStyle(.primaryTextBlack)
                .frame(maxWidth: .infinity)
            // TODO: replace with FirebaseUI
            Button(action: {}) {
                Text("ThirdParyLogin: Google (will be replaced with FirebaseUI)")
            }
            Button(action: {}) {
                Text("ThirdParyLogin: Facebook (will be replaced with FirebaseUI)")
            }
            Button(action: {}) {
                Text("ThirdParyLogin: X (will be replaced with FirebaseUI)")
            }
        }
    }
}

#Preview {
    LoginView()
}
