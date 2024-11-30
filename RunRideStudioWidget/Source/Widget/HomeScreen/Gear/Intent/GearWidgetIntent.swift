//
//  GoalWidgetIntent.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 30.05.2024.
//

import AppIntents

struct GearWidgetIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    
    @Parameter(title: "Gear", default: "")
    var gearID: String

    @Parameter(title: "Time frame", default: .alltime)
    var period: AppIntentPeriodType
    
    @Parameter(title: "Metric", default: .distance)
    var metric: AppIntentMetricType
    
    @Parameter(title: "Goal", default: 0.0)
    var goal: Double
}
