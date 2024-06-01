//
//  SettingsViewModel.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 01.06.2024.
//

import UIKit

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
        self.selectedTheme = Theme.current
        self.useImperialSystem = UserDefaultsConfig.useImperial
    }
}

// MARK: - Public methods
extension SettingsViewModel {
    func applyTheme(_ theme: Theme) {
        UserDefaultsConfig.theme = theme.rawValue

        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }

        scene.windows.forEach { window in
            window.overrideUserInterfaceStyle = selectedTheme.uiUserInterfaceStyle
        }
    }
}

// MARK: - Private methods
extension SettingsViewModel {
    private func applyImperialSystem(_ useImperialSystem: Bool) {
        UserDefaultsConfig.useImperial = useImperialSystem
    }
}
