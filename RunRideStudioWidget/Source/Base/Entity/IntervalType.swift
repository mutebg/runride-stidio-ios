//
//  IntervalType.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 30.05.2024.
//

import AppIntents

enum IntervalType: String, AppEnum {
    case weekly, monthly, yearly

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Intervals"
    static var caseDisplayRepresentations: [IntervalType: DisplayRepresentation] = [
        .weekly: "Weekly",
        .monthly: "Monthly",
        .yearly: "Yearly",
    ]
}
