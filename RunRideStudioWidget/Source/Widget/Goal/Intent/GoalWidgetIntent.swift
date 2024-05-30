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
    var sport: SportType
    
    @Parameter(title: "Time frame", default: .weekly)
    var period: IntervalType
    
    @Parameter(title: "Metric", default: .distance)
    var metric: MetricType
    
    @Parameter(title: "Goal", default: 0.0)
    var goal: Double
}
