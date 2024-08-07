//
//  SignupView.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-06.
//

import SwiftUI

struct SignupView: View {
    @ObservedObject private var viewModel = SignupViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            signupText()
                .padding(.top, 40)
            emailPassInput()
                .padding(.top, 20)
            signupButton()
            Spacer()
            thirdPartyLoginView()
        }
        .padding(.horizontal, 20)
    }
}

private extension SignupView {
    func signupText() -> some View {
        Text("Sign up")
            .font(.customFont(size: .one, weight: .bold))
    }

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
                SecureField("", text: $viewModel.passwordInput)
                    .roundedTextField()
            }
        }
    }

    func signupButton() -> some View {
        VStack(spacing: 14) {
            Button(action: {}) {
                Text("Sign up")
                    .font(.customFont(size: .three))
                    .foregroundStyle(.primaryWhite)
                    .padding(.vertical, 11)
                    .frame(maxWidth: .infinity)
            }
            .roundedButton(.three)
            HStack(spacing: 20) {
                Text("Do you have account?")
                    .font(.customFont(size: .two))
                    .foregroundStyle(.primaryTextBlack)
                Button(action: {
                    viewModel.didTapLoginButton()
                }) {
                    Text("Log in")
                        .font(.customFont(size: .two, weight: .bold))
                        .foregroundStyle(.accentBlue)
                }
                .fullScreenCover(isPresented: $viewModel.isPresentedLoginView) {
                    LoginView()
                }
            }
        }
    }

    func thirdPartyLoginView() -> some View {
        VStack(spacing: 20) {
            Text("Or sign up with")
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
    SignupView()
}
