//
//  TabBarView.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-07.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var authManager: AuthManager

    var body: some View {
        TabView {
           KitsView()
                .tabItem {
                    Label("Kits", systemImage: "shippingbox")
                }
           GearsView()
                .environmentObject(authManager)
                .tabItem {
                    Label("Gears", systemImage: "wrench.adjustable.fill")
                }
           SettingsView()
                .environmentObject(authManager)
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .tint(.accentBlue)
    }
}

#Preview {
    TabBarView()
}
