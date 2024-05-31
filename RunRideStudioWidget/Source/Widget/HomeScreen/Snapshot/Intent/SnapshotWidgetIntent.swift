//
//  SnapshotWidgetIntent.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 30.05.2024.
//

import AppIntents

struct SnapshotWidgetIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"

    @Parameter(title: "Sport", default: .run)
    var sport: SportType
    
    @Parameter(title: "Time frame", default: .weekly)
    var period: IntervalType
}
