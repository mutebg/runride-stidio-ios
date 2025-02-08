import SwiftUI
import WidgetKit

struct AveragesWidget: Widget {
    let kind: String = "RunRide_Averages"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: AveragesWidgetIntent.self,
            provider: AveragesWidgetTimelineProvider()
        ) { entry in
            AveragesView(
                distance: entry.distance,
                totalElevationGain: entry.totalElevationGain,
                movingTime: entry.movingTime,
                activities: entry.activities,
                sportType: entry.configuration.sport.defaultType,
                periodType: entry.configuration.period.defaultType
            )
            .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Averages Widget")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
