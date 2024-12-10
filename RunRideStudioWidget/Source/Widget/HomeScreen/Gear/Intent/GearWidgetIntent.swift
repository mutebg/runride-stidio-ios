//
//  GoalWidgetIntent.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 30.05.2024.
//

import AppIntents

struct GearWidgetIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    
    // TODO: id of the gear, this needs to be a list, coming from the API
    @Parameter(title: "Gear")
    var gear: GearChoice

    @Parameter(title: "Time frame", default: .alltime)
    var period: AppIntentPeriodType
    
    @Parameter(title: "Metric", default: .distance)
    var metric: AppIntentMetricType
    
    @Parameter(title: "Goal", default: 0.0)
    var goal: Double
}
