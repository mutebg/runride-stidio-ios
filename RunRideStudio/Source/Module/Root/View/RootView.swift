//
//  RootView.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 01.06.2024.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    @StateObject private var viewModel = RootViewModel()
    
    var body: some View {
        TabView(selection: $viewModel.selectedIndex) {
            homeView
                .tabItem {
                    Label(
                        RootViewModel.Tab.overview.title,
                        systemImage: RootViewModel.Tab.overview.imageName
                    )
                }
                .tag(RootViewModel.Tab.overview)
            
            WebView(urlPath: "https://runride.studio/app/timeline?hideNav=1&auth_token=\(UserDefaultsConfig.stravaToken ?? "")")
                .tabItem {
                    Label(
                        RootViewModel.Tab.timeline.title,
                        systemImage: RootViewModel.Tab.timeline.imageName
                    )
                }
                .tag(RootViewModel.Tab.timeline)

            WebView(urlPath: "https://runride.studio/app/compare?hideNav=1&auth_token=\(UserDefaultsConfig.stravaToken ?? "")")
                .tabItem {
                    Label(
                        RootViewModel.Tab.compare.title,
                        systemImage: RootViewModel.Tab.compare.imageName
                    )
                }
                .tag(RootViewModel.Tab.compare)

            SettingsView()
                .tabItem {
                    Label(
                        RootViewModel.Tab.settings.title,
                        systemImage: RootViewModel.Tab.settings.imageName
                    )
                }
                .tag(RootViewModel.Tab.settings)
        }
    }
}

// MARK: - Private methods
extension RootView {
    private var homeView: some View {
        NavigationStack {
            HomeView()
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        NavigationBarView(
                            title: "Hello, athlete",
                            subtitle: "Today, \(viewModel.formattedCurrentDate)")
                    }
                }
        }
    }
}

#Preview {
    RootView()
}
