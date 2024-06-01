//
//  SettingsViewModel.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 01.06.2024.
//

import UIKit

enum Theme: String, CaseIterable, Identifiable {
    case auto = "automatic"
    case light
    case dark
    
    var id: String { self.rawValue }
}

final class SettingsViewModel: ObservableObject {
    @Published var selectedTheme: Theme {
        didSet {
            applyTheme(selectedTheme)
        }
    }
    
    @Published var useImperialSystem: Bool {
        didSet {
            applyImperialSystem(useImperialSystem)
        }
    }
    
    init() {
        self.selectedTheme = .auto
        self.useImperialSystem = UserDefaultsConfig.useImperial
    }
}

// MARK: - Private methods
extension SettingsViewModel {
    private func applyTheme(_ theme: Theme) {
        switch theme {
        case .auto:
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .unspecified
        case .light:
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
        case .dark:
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
        }
    }
    
    private func applyImperialSystem(_ useImperialSystem: Bool) {
        UserDefaultsConfig.useImperial = useImperialSystem
    }
}
