//
//  Theme.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 01.06.2024.
//

import UIKit

enum Theme: String, CaseIterable, Identifiable {
    case auto = "automatic"
    case light
    case dark
    
    static var current: Theme {
        Theme(rawValue: UserDefaultsConfig.theme ?? Theme.auto.rawValue) ?? .auto
    }
    
    var id: String {
        rawValue
    }
    
    var uiUserInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .auto:
            return .unspecified
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
