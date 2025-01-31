//
//  AppIntentMonthlyType.swift
//  RunRideStudio
//
//  Created by Stoyan Delev on 31.01.25.
//



import AppIntents

enum AppIntentMonthlyType: String, AppEnum {
    case monthly, last30days

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Intervals"
    static var caseDisplayRepresentations: [AppIntentMonthlyType: DisplayRepresentation] = [
        .monthly: "This month",
        .last30days: "Last 30 days",
    ]
    
    var defaultType: PeriodType {
        switch self {
            
        case .monthly:
            return .monthly
        case .last30days:
            return .last30days
        }
    }
}
