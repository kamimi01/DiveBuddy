//
//  SettingsView.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-07.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.openURL) var openURL

    var body: some View {
        VStack(alignment: .leading) {
            profile()
                .padding(.horizontal, 20)
            List {
                Section(header: Text("Support")) {
                    knowDeveloper()
                }

                Section(header: Text("About App")) {
                    termsOfUse()
                    privacyPolicy()
                    version()
                }
            }
            .listStyle(.plain)
            .frame(maxHeight: 300)
            logoutButton()
            Spacer()
        }
        .padding(.top, 20)
    }
}

private extension SettingsView {
    func profile() -> some View {
        Text("Guest")
            .foregroundStyle(.primaryTextBlack)
            .font(.customFont(size: .five, weight: .bold))
    }

    func termsOfUse() -> some View {
        Button(action:{
            openURL(URL(string: "https://github.com/kamimi01")!)
        }) {
            HStack {
                Text("Terms of User")
                Spacer()
            }
        }
        .foregroundStyle(.primaryTextBlack)
    }

    func privacyPolicy() -> some View {
        Button(action:{
            openURL(URL(string: "https://github.com/kamimi01")!)
        }) {
            HStack {
                Text("Privacy Policy")
                Spacer()
            }
        }
        .foregroundStyle(.primaryTextBlack)
    }

    func knowDeveloper() -> some View {
        Button(action:{
            openURL(URL(string: "https://github.com/kamimi01")!)
        }) {
            HStack {
                Text("Know Developer")
                Spacer()
            }
        }
        .foregroundStyle(.primaryTextBlack)
    }

    func version() -> some View {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
        let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""

        return HStack {
            Text("Version")
                .foregroundStyle(.primaryTextBlack)
            Spacer()
            Text("\(version)(\(buildNumber))")
                .foregroundStyle(.primaryTextBlack)
        }
    }

    func logoutButton() -> some View {
        Button(action: {}) {
            Text("Logout")
                .font(.customFont(size: .three, weight: .bold))
                .foregroundStyle(.accentBlue)
                .padding(.vertical, 11)
                .frame(maxWidth: .infinity)
        }
        .roundedButton(.one)
    }
}

#Preview {
    SettingsView()
}
