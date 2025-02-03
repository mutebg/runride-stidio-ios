//
//  MonthlyWidget.swift
//  RunRideStudio
//
//  Created by Stoyan Delev on 30.01.25.
//


import SwiftUI
import WidgetKit

struct MonthlyWidget: Widget {
    let kind: String = "RunRide_Widget_Monthly"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent:  MonthlyWidgetIntent.self,
            provider: MonthlyWidgetTimelineProvider()
        ) { entry in
            GridWidget(
                sportType: entry.configuration.sport.defaultType,
                metricType: entry.configuration.metric.defaultType,
                periodType: entry.configuration.period.defaultType,
                data: entry.data,
                showEmoji: entry.configuration.showEmoji
                
            ).containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Monthly Widget")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    MonthlyWidget()
} timeline: {
    MonthlyWidgetEntry(date: .now, data: [], configuration: .runner)
    MonthlyWidgetEntry(date: .now, data: [], configuration: .ridder)
}

// Only for preview
extension MonthlyWidgetIntent {
    fileprivate static var runner: MonthlyWidgetIntent {
        let intent = MonthlyWidgetIntent()
        intent.sport = .run
        intent.metric = .distance
        intent.period = .last30days
        intent.showEmoji = true
        return intent
    }
    
    fileprivate static var ridder: MonthlyWidgetIntent {
        let intent = MonthlyWidgetIntent()
        intent.sport = .all
        intent.metric = .distance
        intent.period = .last30days
        intent.showEmoji = false
        return intent
    }
}
