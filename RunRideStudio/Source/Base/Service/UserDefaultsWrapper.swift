//
//  UserDefaultsWrapper.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 27.05.2024.
//

import Foundation

@propertyWrapper
struct UserDefaultsWrapper<T> {
    let key: String
    let defaultValue: T
    
    private let userDefaults = UserDefaults(suiteName: "group.runride_studio")

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            userDefaults?.object(forKey: key) as? T ?? defaultValue
        }
        set {
            if (newValue as AnyObject) is NSNull {
                userDefaults?.removeObject(forKey: key)
                return
            }
            
            userDefaults?.set(newValue, forKey: key)
        }
    }
}

/// Typesafe wrapper to store keys in UserDefaults.
struct UserDefaultsConfig {
    public enum Keys: String {
        case stravaId = "strava_id"
        case stravaToken = "token"
        case useImperial
        case theme
    }

    // TODO: - Add to keychain
    @UserDefaultsWrapper(Keys.stravaId.rawValue, defaultValue: nil)
    static var stravaId: String?
    
    // TODO: - Add to keychain
    @UserDefaultsWrapper(Keys.stravaToken.rawValue, defaultValue: nil)
    static var stravaToken: String?

    @UserDefaultsWrapper(Keys.useImperial.rawValue, defaultValue: false)
    static var useImperial: Bool
    
    @UserDefaultsWrapper(Keys.theme.rawValue, defaultValue: nil)
    static var theme: String?
}
