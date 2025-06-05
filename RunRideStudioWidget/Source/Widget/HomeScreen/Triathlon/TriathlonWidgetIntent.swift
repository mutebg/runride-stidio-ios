//
//  TriathlonWidgetIntent.swift
//  RunRideStudio
//
//  Created by Stoyan Delev on 4.06.25.
//

import AppIntents

struct TriathlonWidgetIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"

    @Parameter(title: "Period", default: .last7days)
    var period: AppIntentPeriodType
}
