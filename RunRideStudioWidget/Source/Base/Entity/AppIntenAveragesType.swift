//
//  AppIntentMonthlyType.swift
//  RunRideStudio
//
//  Created by Stoyan Delev on 31.01.25.
//



import AppIntents

enum AppIntentAveragesType: String, AppEnum {
    case last7days, last30days

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Intervals"
    static var caseDisplayRepresentations: [AppIntentAveragesType: DisplayRepresentation] = [
        .last7days: "Last 7 days",
        .last30days: "Last 30 days",
    ]
    
    var defaultType: PeriodType {
        switch self {
            
        case .last7days:
            return .last7days
        case .last30days:
            return .last30days
        }
    }
}
