//
//  IntervalType.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 31.05.2024.
//

import Foundation

enum IntervalType: String, CaseIterable, Identifiable, Codable {
    case weekly, monthly, yearly
    
    var title: String {
        switch self {
        case .weekly:
            return "Week"
        case .monthly:
            return "Month"
        case .yearly:
            return "Year"
        }
    }
    
    var id: String {
        rawValue
    }
}
