//
//  AppIntentIntervalType.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 31.05.2024.
//

import AppIntents

enum AppIntentPeriodType: String, AppEnum {
    case weekly, monthly, yearly, alltime, last7days, last30days, last12months

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Intervals"
    static var caseDisplayRepresentations: [AppIntentPeriodType: DisplayRepresentation] = [
        .weekly: "This week",
        .monthly: "This month",
        .yearly: "This year",
        .alltime: "All time",
        .last7days: "Last 7 days",
        .last30days: "Last 30 days",
        .last12months: "Last 12 months",
    ]
    
    var defaultType: PeriodType {
        switch self {
        case .weekly:
            return .weekly
        case .monthly:
            return .monthly
        case .yearly:
            return .yearly
        case .alltime:
            return .alltime
        case .last7days:
            return .last7days
        case .last30days:
            return .last30days
        case .last12months:
            return .last12months
        }
    }
}
