//
//  SettingsView.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 01.06.2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    @EnvironmentObject private var viewModel: SettingsViewModel
    @State private var showingThemeMenu = false

    var body: some View {
        NavigationStack {
            List {
                appearanceSectionView
                preferencesSectionView
                logoutSectionView
            }
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

// MARK: - Private methods
extension SettingsView {
    private var appearanceSectionView: some View {
        Section(header: Text("Appearance")) {
            HStack {
                Text("Theme")

                Spacer()

                Menu {
                    Picker("Theme", selection: $viewModel.selectedTheme) {
                        ForEach(Theme.allCases) { theme in
                            Text(theme.rawValue)
                                .tag(theme)
                        }
                    }
                } label: {
                    HStack {
                        Text(viewModel.selectedTheme.rawValue)
                            .foregroundColor(.gray)
                            .padding(.horizontal, Spacing.space6)
                            .padding(.vertical, Spacing.space4)
                            .background(.textBrand1.opacity(0.05))
                            .clipShape(.rect(cornerRadius: 8))
                    }
                }
            }
        }
    }
    
    private var preferencesSectionView: some View {
        Section(header: Text("Preferences")) {
            Toggle(isOn: $viewModel.useImperialSystem) {
                Text("Use Imperial System")
            }
        }
    }
    
    private var logoutSectionView: some View {
        Section {
            Button(action: {
                authViewModel.logout()
            }) {
                Text("Logout")
                    .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(SettingsViewModel())
}
