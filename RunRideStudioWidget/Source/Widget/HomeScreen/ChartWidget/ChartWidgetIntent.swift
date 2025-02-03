//
//  ChartWidgetIntent.swift
//  RunRideStudio
//
//  Created by Stoyan Delev on 3.02.25.
//

import AppIntents

struct ChartWidgetIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"

    @Parameter(title: "Sport", default: .run)
    var sport: AppIntentMonthlyWidgetSportType
    
    @Parameter(title: "Period", default: .last30days)
    var period: AppIntentMonthlyType
}
