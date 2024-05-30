//
//  RunRideStudioApp.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 27.05.2024.
//

import SwiftUI

@main
struct RunRide_Studio_WidgetsApp: App {
    @StateObject var authViewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            Group {
                if authViewModel.isLoggedIn {
                    ContentView()
                } else {
                    AuthView()
                }
            }
            .onOpenURL(perform: authViewModel.handleURL(_:))
            .environmentObject(authViewModel)
        }
    }
}
