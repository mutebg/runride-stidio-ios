//
//  AuthViewModel.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 30.05.2024.
//

import Foundation

final class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var stravaId: String?
    @Published var stravaToken: String?
    
    init() {
        self.stravaId = UserDefaultsConfig.stravaId
        self.stravaToken = UserDefaultsConfig.stravaToken
        self.isLoggedIn = stravaId != nil && stravaToken != nil
    }
}

// MARK: - Public methods
extension AuthViewModel {
    func handleURL(_ url: URL) {
        let items = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems ?? []
        
        let id = items.first { $0.name == "id" }?.value
        let token = items.first { $0.name == "token" }?.value
        
        guard let id, let token else { return }
        
        UserDefaultsConfig.stravaId = id
        UserDefaultsConfig.stravaToken = token
        
        stravaId = id
        stravaToken = token
        isLoggedIn = true
    }
    
    func logout() {
        UserDefaultsConfig.stravaId = nil
        UserDefaultsConfig.stravaToken = nil
        stravaId = nil
        stravaToken = nil
        isLoggedIn = false
    }
}
