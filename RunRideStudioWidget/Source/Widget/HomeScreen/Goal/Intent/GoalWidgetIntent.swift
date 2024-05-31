//
//  GoalWidgetIntent.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 30.05.2024.
//

import AppIntents

struct GoalWidgetIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"

    @Parameter(title: "Sport", default: .run)
    var sport: AppIntentSportType
    
    @Parameter(title: "Time frame", default: .weekly)
    var period: AppIntentIntervalType
    
    @Parameter(title: "Metric", default: .distance)
    var metric: AppIntentMetricType
    
    @Parameter(title: "Goal", default: 0.0)
    var goal: Double
}
