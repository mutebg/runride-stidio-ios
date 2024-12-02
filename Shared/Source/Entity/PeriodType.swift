//
//  IntervalType.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 31.05.2024.
//

import Foundation

enum PeriodType: String, CaseIterable, Identifiable, Codable {
    case  alltime, weekly, monthly, yearly,last7days, last30days, last12months
    
    var title: String {
        switch self {
        case .alltime:
            return "All time"
        case .weekly:
            return "Week"
        case .monthly:
            return "Month"
        case .yearly:
            return "Year"
        case .last7days:
            return "Last 7 days"
        case .last30days:
            return "Last 30 days"
        case .last12months:
            return "Last 12 months"
        }
    }
    
    var id: String {
        rawValue
    }
}
