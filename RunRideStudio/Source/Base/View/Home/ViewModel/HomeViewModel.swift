//
//  HomeViewModel.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 31.05.2024.
//

import Foundation

final class HomeViewModel: ObservableObject {
    private var stravaId: String?
    private var stravaToken: String?
    
    init() {
        self.stravaId = UserDefaultsConfig.stravaId
        self.stravaToken = UserDefaultsConfig.stravaToken
    }
}

// MARK: - Public methods
extension HomeViewModel {
    var websiteUrl: URL? {
        let token = stravaToken ?? ""
        let id = stravaId ?? ""
        return URL(string: "https://runride.studio/ok?token=\(token)&id=\(id)")
    }
}
