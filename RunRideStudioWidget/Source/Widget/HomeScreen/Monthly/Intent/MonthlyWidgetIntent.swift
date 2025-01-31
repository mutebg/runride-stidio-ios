//
//  MonthlyWidgetIntent.swift
//  RunRideStudio
//
//  Created by Stoyan Delev on 30.01.25.
//

import AppIntents

struct MonthlyWidgetIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"

    @Parameter(title: "Sport", default: .run)
    var sport: AppIntentSportType
    
    @Parameter(title: "Period", default: .last30days)
    var period: AppIntentMonthlyType
    
    @Parameter(title: "Metric", default: .distance)
    var metric: AppIntentMetricType
}
