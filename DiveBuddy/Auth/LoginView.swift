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
        VStack(alignment: .leading, spacing: 30) {
            loginText()
                .padding(.top, 40)
            emailPassInput()
                .padding(.top, 20)
            logInButton()
            guestLogin()
            Spacer()
//            thirdPartyLoginView()
        }
        .padding(.horizontal, 20)
        .alert(viewModel.errorMessage, isPresented: $viewModel.isPresentedErrorAlert) {
            Button("OK", role: .cancel, action: {
                viewModel.didTapOKInErrorAlert()
            })
        }
    }
}

private extension LoginView {
    func loginText() -> some View {
        Text("Log in")
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

    func logInButton() -> some View {
        VStack(spacing: 14) {
            Button(action: {
                viewModel.didTapLogInButton()
            }) {
                Text("Log in")
                    .font(.customFont(size: .three))
                    .foregroundStyle(.primaryWhite)
                    .padding(.vertical, 11)
                    .frame(maxWidth: .infinity)
            }
            .roundedButton(.three)
            .fullScreenCover(isPresented: $viewModel.isPresentedTabBarView) {
                TabBarView()
            }
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

    func guestLogin() -> some View {
        Button(action: {
            viewModel.didTapGuestLoginButton()
        }) {
            Text("Continue as Guest")
                .font(.customFont(size: .two, weight: .bold))
                .foregroundStyle(.accentBlue)
                .frame(maxWidth: .infinity)
        }
        .fullScreenCover(isPresented: $viewModel.isPresentedTabBarView) {
            TabBarView()
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
