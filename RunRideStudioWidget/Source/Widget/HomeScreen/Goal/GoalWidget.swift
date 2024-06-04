//
//  GoalWidget.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 30.05.2024.
//

import SwiftUI
import WidgetKit

struct GoalWidget: Widget {
    let kind: String = "RunRide_Widget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: GoalWidgetIntent.self,
            provider: GoalWidgetTimelineProvider()
        ) { entry in
            GoalSmallCardView(
                sportType: entry.configuration.sport.defaultType,
                metricType: entry.configuration.metric.defaultType,
                intervalType: entry.configuration.period.defaultType,
                currentValue: entry.value,
                goalValue: entry.configuration.goal,
                activitiesCount: entry.activities
            )
            .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Goal Widget")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    GoalWidget()
} timeline: {
    GoalWidgetEntry(date: .now, value: 150, activities: 8, configuration: .runner)
    GoalWidgetEntry(date: .now, value: 120, activities: 8, configuration: .ridder)
}

// Only for preview
extension GoalWidgetIntent {
    fileprivate static var runner: GoalWidgetIntent {
        let intent = GoalWidgetIntent()
        intent.goal = 200.0
        intent.sport = .run
        intent.period = .monthly
        intent.metric = .distance
        return intent
    }
    
    fileprivate static var ridder: GoalWidgetIntent {
        let intent = GoalWidgetIntent()
        intent.goal = 160.0
        intent.sport = .ride
        intent.period = .weekly
        intent.metric = .distance
        return intent
    }
}
