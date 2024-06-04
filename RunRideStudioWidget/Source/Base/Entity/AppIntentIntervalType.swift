//
//  AppIntentIntervalType.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 31.05.2024.
//

import AppIntents

enum AppIntentIntervalType: String, AppEnum {
    case weekly, monthly, yearly

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Intervals"
    static var caseDisplayRepresentations: [AppIntentIntervalType: DisplayRepresentation] = [
        .weekly: "Weekly",
        .monthly: "Monthly",
        .yearly: "Yearly",
    ]
    
    var defaultType: IntervalType {
        switch self {
        case .weekly:
            return .weekly
        case .monthly:
            return .monthly
        case .yearly:
            return .yearly
        }
    }
}
