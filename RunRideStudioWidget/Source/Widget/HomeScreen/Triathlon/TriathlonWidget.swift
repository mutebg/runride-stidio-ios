//
//  TriathlonWidget.swift
//  RunRideStudio
//
//  Created by Stoyan Delev on 4.06.25.
//

import SwiftUI
import WidgetKit


struct TriathlonWidget: Widget {
    let kind: String = "RunRide_Triathlon_Widget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: TriathlonWidgetIntent.self,
            provider: TriathlonWidgetTimelineProvider()
        ) { entry in
            TriathlonView(
                data: entry.data,
            )
            .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Triathlon Widget")
        .supportedFamilies([.systemMedium])
    }
}
