//
//  RunRide_Widget.swift
//  RunRide Widget
//
//  Created by Stoyan Delev on 7.03.24.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), value: 100, activities: 8, configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), value: 100, activities: 8, configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, value: 100, activities: 8, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let value: Double
    let activities: Int
    let configuration: ConfigurationAppIntent
}

struct RunRide_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("This " + entry.configuration.period.rawValue)
            Text("Value: " + String(entry.value))
            Text("Activities: " + String(entry.activities))
        }
    }
}

struct RunRide_Widget: Widget {
    let kind: String = "RunRide_Widget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            RunRide_WidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var runner: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.goal = "200"
        intent.sport = .run
        intent.period = .monthly
        intent.metric = .distance
        return intent
    }
    
    fileprivate static var ridder: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.goal = "160"
        intent.sport = .ride
        intent.period = .weekly
        intent.metric = .distance
        return intent
    }
}

#Preview(as: .systemSmall) {
    RunRide_Widget()
} timeline: {
    SimpleEntry(date: .now, value: 100, activities: 8, configuration: .runner)
    SimpleEntry(date: .now, value: 100, activities: 8, configuration: .ridder)
}
