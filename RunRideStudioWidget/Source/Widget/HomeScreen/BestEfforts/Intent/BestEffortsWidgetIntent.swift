import AppIntents

struct BestEffortsWidgetIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"

    // @Parameter(title: "Sport", default: .run)
    // var sport: AppIntentSportType
    
    @Parameter(title: "Time frame", default: .weekly)
    var period: AppIntentPeriodType
} 