//
//  SportType.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 31.05.2024.
//

import Foundation

enum SportType: String, CaseIterable {
    case run, ride, swim, walk, hike, rowing
    
    var title: String {
        switch self {
        case .run:
            return "Run"
        case .ride:
            return "Ride"
        case .swim:
            return "Swim"
        case .walk:
            return "Walk"
        case .hike:
            return "Hike"
        case .rowing:
            return "Rowing"
        }
    }
}
