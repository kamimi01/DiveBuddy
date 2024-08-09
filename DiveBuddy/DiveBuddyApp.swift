//
//  DiveBuddyApp.swift
//  DiveBuddy
//
//  Created by mikaurakawa on 2024-08-03.
//

import SwiftUI

@main
struct DiveBuddyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            WelcomeView()
        }
    }
}
