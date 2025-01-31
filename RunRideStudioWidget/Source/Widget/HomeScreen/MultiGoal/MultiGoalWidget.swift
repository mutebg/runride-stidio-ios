//
//  GoalWidget.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 30.05.2024.
//

import SwiftUI
import WidgetKit

struct MultiGoalWidget: Widget {
    let kind: String = "RunRide_Widget_multi"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: MultiGoalWidgetIntent.self,
            provider: MultiGoalWidgetTimelineProvider()
        ) { entry in
            MultiGoalCard(
                sportType:  entry.configuration.sport.map { $0.defaultType },
                metricType: entry.configuration.metric.defaultType,
                intervalType: entry.configuration.period.defaultType,
                currentValue: entry.value,
                goalValue: entry.configuration.goal,
                activitiesCount: entry.activities
            )
            .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Multi Sport Goal Widget")
        .supportedFamilies([.systemMedium])
    }
}

#Preview(as: .systemMedium) {
    MultiGoalWidget()
} timeline: {
    MultiGoalWidgetEntry(date: .now, value: [150,200,100,400], activities: [10,12,3,8], configuration: .runner)
}

// Only for preview
extension MultiGoalWidgetIntent {
    fileprivate static var runner: MultiGoalWidgetIntent {
        let intent = MultiGoalWidgetIntent()
        intent.goal = [200.0, 240, 200, 100]
        intent.sport = [.run, .ride, .swim, .hike]
        intent.period = .monthly
        intent.metric = .distance
        return intent
    }
}
