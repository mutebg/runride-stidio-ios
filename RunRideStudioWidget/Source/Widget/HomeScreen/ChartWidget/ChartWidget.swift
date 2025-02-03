//
//  ChartWidget.swift
//  RunRideStudio
//
//  Created by Stoyan Delev on 3.02.25.
//

import SwiftUI
import WidgetKit

struct ChartWidget: Widget {
    let kind: String = "RunRide_Widget_Chart"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent:  ChartWidgetIntent.self,
            provider: ChartWidgetTimelineProvider()
        ) { entry in
            ChartView(
                sportType: entry.configuration.sport.defaultType,
                periodType: entry.configuration.period.defaultType,
                data: entry.data
            ).containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Chart Widget")
        .supportedFamilies([.systemMedium])
    }
}
