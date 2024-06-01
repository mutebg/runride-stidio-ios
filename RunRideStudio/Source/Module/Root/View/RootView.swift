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

            settingsView
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
                        VStack {
                            NavigationBarView(
                                title: "Hello, athlete",
                                subtitle: "Today, \(viewModel.formattedCurrentDate)")
                        }
                    }
                }
        }
    }
    
    private var settingsView: some View {
        NavigationStack {
            Text("Tab Content 2")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            NavigationBarView(
                                title: RootViewModel.Tab.settings.title
                            )
                        }
                    }
                }
        }
    }
}

#Preview {
    RootView()
}
