//
//  ContentView.swift
//  RunRide Studio Widgets
//
//  Created by Stoyan Delev on 3.03.24.
//

import SwiftUI

struct ContentView: View {
    private enum Tab: Hashable {
        case overview
        case settings
        
        var title: String {
            switch self {
            case .overview:
                return "Overview"
            case .settings:
                return "Settings"
            }
        }
        
        var imageName: String {
            switch self {
            case .overview:
                return "chart.line.uptrend.xyaxis.circle.fill"
            case .settings:
                return "gearshape.fill"
            }
        }
    }

    @EnvironmentObject private var authViewModel: AuthViewModel
    @State private var selectedIndex: Tab = .overview
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            NavigationStack {
                HomeView()
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            VStack {
                                Text("Hello, Arman")
                                    .font(.headline)
                                Text("Today, 31 May")
                                    .font(.caption)
                            }
                        }
                    }
            }
            .tabItem {
                Text(Tab.overview.title)
                Image(systemName: Tab.overview.imageName)
                    .renderingMode(.template)
            }
            .tag(Tab.overview)

            Text("Tab Content 2")
                .tabItem {
                    Text(Tab.settings.title)
                    Image(systemName: Tab.settings.imageName)
                        .renderingMode(.template)
                }
                .tag(Tab.settings)
        }
    }
}

#Preview {
    ContentView()
}
