//
//  MonthAccessoryWidget.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 30.05.2024.
//

import SwiftUI
import WidgetKit

struct MonthAccessoryWidget: Widget {
    let kind: String = "accessory.month.runride.widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: MonthAccessoryWidgetTimelineProvider()
        ) { entry in
            MonthAccessoryWidgetView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Monthly Distance")
        .description("Total distance you ran this month")
        .supportedFamilies([.accessoryCircular])
    }
}

#Preview(as: .accessoryCircular) {
    MonthAccessoryWidget()
} timeline: {
    MonthAccessoryWidgetEntry(date: .now, value: 150)
}
