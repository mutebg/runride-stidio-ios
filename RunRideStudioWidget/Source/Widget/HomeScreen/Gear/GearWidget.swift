//
//  GoalWidget.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 30.05.2024.
//

import SwiftUI
import WidgetKit

struct GearWidget: Widget {
    let kind: String = "RunRide_Gear"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: GearWidgetIntent.self,
            provider: GearWidgetTimelineProvider()
        ) { entry in
            GearSmallCardView(
                gearName: entry.configuration.gear.gearName,
                metricType: entry.configuration.metric.defaultType,
                intervalType: entry.configuration.period.defaultType,
                currentValue: entry.value,
                goalValue: entry.configuration.goal,
                activitiesCount: entry.activities
            )
            .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Gear Widget")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    GearWidget()
} timeline: {
    GearWidgetEntry(date: .now, value: 150, activities: 8, configuration: .runner)
    GearWidgetEntry(date: .now, value: 120, activities: 8, configuration: .ridder)
}

// Only for preview
extension GearWidgetIntent {
    fileprivate static var runner: GearWidgetIntent {
        let intent = GearWidgetIntent()
        intent.goal = 200.0
        intent.gear = .init(gearID: "0", gearName: "Hoka Mach X2")
        intent.period = .alltime
        intent.metric = .distance
        return intent
    }
    
    fileprivate static var ridder: GearWidgetIntent {
        let intent = GearWidgetIntent()
        intent.goal = 1600.0
        intent.gear = .init(gearID: "1", gearName: "Trek Marlin 4")
        intent.period = .last12months
        intent.metric = .distance
        return intent
    }
}
