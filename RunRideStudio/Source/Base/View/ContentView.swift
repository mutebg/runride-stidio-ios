//
//  ContentView.swift
//  RunRide Studio Widgets
//
//  Created by Stoyan Delev on 3.03.24.
//

import SwiftUI

struct ContentView: View {
    private enum Tab: Hashable {
        case home
        case settings
    }

    @EnvironmentObject private var authViewModel: AuthViewModel
    @State private var selectedIndex: Tab = .home
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            NavigationStack {
                HomeView()
            }
                .tabItem {
                    Text("Home")
                    Image(systemName: "house.fill")
                        .renderingMode(.template)
                }
                .tag(Tab.home)

            Text("Tab Content 2")
                .tabItem {
                    Text("Settings")
                    Image(systemName: "info.circle")
                        .renderingMode(.template)
                }
                .tag(Tab.settings)
        }
    }
}

#Preview {
    ContentView()
}
