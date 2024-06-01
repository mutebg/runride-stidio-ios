//
//  RunRideStudioApp.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 27.05.2024.
//

import SwiftUI

@main
struct RunRide_Studio_WidgetsApp: App {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var settingsViewModel = SettingsViewModel()

    var body: some Scene {
        WindowGroup {
            Group {
                if authViewModel.isLoggedIn {
                    RootView()
                } else {
                    AuthView()
                }
            }
            .onOpenURL(perform: authViewModel.handleURL(_:))
            .environmentObject(authViewModel)
            .environmentObject(settingsViewModel)
            .onAppear {
                settingsViewModel.applyTheme(settingsViewModel.selectedTheme)
            }
        }
    }
}
