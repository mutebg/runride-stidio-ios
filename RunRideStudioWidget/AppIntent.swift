import WidgetKit
import AppIntents

enum WidgetSports: String, AppEnum {
    case run, ride, swim, walk, hike, rowing

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Sports"
    static var caseDisplayRepresentations: [WidgetSports : DisplayRepresentation] = [
        .run: "Run",
        .ride: "Ride",
        .swim: "Swim",
        .walk: "Walk",
        .hike: "Hike",
        .rowing: "Rowing",
    ]
}

enum WidgetIntervals: String, AppEnum {
    case weekly, monthly, yearly

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Intervals"
    static var caseDisplayRepresentations: [WidgetIntervals : DisplayRepresentation] = [
        .weekly: "Weekly",
        .monthly: "Monthly",
        .yearly: "Yearly",
    ]
}

enum WidgetMetrics: String, AppEnum {
    case distance, time, elevation

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Metrics"
    static var caseDisplayRepresentations: [WidgetMetrics : DisplayRepresentation] = [
        .distance: "Distance",
        .time: "Time",
        .elevation: "Elevation",
    ]
}

struct ConfigurationAppIntentGoal: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")

    @Parameter(title: "Sport", default: .run)
    var sport: WidgetSports
    
    @Parameter(title: "Time frame", default: .weekly)
    var period: WidgetIntervals
    
    @Parameter(title: "Metric", default: .distance)
    var metric: WidgetMetrics
    
    @Parameter(title: "Goal", default: 0.0)
    var goal: Double
}

struct ConfigurationAppIntentSnapshot: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")

    @Parameter(title: "Sport", default: .run)
    var sport: WidgetSports
    
    @Parameter(title: "Time frame", default: .weekly)
    var period: WidgetIntervals
}
