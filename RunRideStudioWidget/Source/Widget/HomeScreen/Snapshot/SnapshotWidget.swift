//
//  SnapshotWidget.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 30.05.2024.
//

import SwiftUI
import WidgetKit

struct SnapshotWidget: Widget {
    let kind: String = "RunRide_Snapshot"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: SnapshotWidgetIntent.self,
            provider: SnapshotWidgetTimelineProvider()
        ) { entry in
            SnapshotWidgetView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Snapshot Widget")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemMedium) {
    SnapshotWidget()
} timeline: {
    SnapshotWidgetEntry(date: .now, configuration: .runner)
    SnapshotWidgetEntry(date: .now, configuration: .ridder)
}

// Only for preview
extension SnapshotWidgetIntent {
    fileprivate static var runner: SnapshotWidgetIntent {
        let intent = SnapshotWidgetIntent()
        intent.sport = .run
        intent.period = .monthly
        return intent
    }
    
    fileprivate static var ridder: SnapshotWidgetIntent {
        let intent = SnapshotWidgetIntent()
        intent.sport = .ride
        intent.period = .weekly
        return intent
    }
}
