import WidgetKit

struct AveragesWidgetEntry: TimelineEntry {
    let date: Date
    let distance: Double
    let totalElevationGain: Double
    let movingTime: Double
    let activities: Double
    let configuration: AveragesWidgetIntent
}
