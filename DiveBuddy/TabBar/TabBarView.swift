//
//  TabBarView.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-07.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
           KitsView()
                .tabItem {
                    Label("Kits", systemImage: "shippingbox")
                }
           GearsView()
                .tabItem {
                    Label("Gears", systemImage: "wrench.adjustable.fill")
                }
           SettingsView()
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
