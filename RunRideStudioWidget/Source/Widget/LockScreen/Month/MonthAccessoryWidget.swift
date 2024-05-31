//
//  MonthAccessoryWidget.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 30.05.2024.
//

import SwiftUI
import WidgetKit

struct RideMonthAccessoryWidget: Widget {
    private let kind: String = "accessory.ride.month.runride.widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: MonthAccessoryWidgetTimelineProvider(
                sportType: .ride
            )
        ) { entry in
            MonthAccessoryWidgetView(
                entry: entry,
                sportName: "Ride"
            )
            .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Monthly Ride Distance")
        .description("Total distance you rode this month")
        .supportedFamilies([.accessoryCircular])
    }
}

struct RunMonthAccessoryWidget: Widget {
    private let kind: String = "accessory.run.month.runride.widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: MonthAccessoryWidgetTimelineProvider(
                sportType: .run
            )
        ) { entry in
            MonthAccessoryWidgetView(
                entry: entry,
                sportName: "Run"
            )
            .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Monthly Run Distance")
        .description("Total distance you ran this month")
        .supportedFamilies([.accessoryCircular])
    }
}

#Preview(as: .accessoryCircular) {
    RunMonthAccessoryWidget()
} timeline: {
    MonthAccessoryWidgetEntry(date: .now, value: 150)
}

#Preview(as: .accessoryCircular) {
    RideMonthAccessoryWidget()
} timeline: {
    MonthAccessoryWidgetEntry(date: .now, value: 150)
}
