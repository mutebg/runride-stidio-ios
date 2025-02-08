import AppIntents

struct AveragesWidgetIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"

    @Parameter(title: "Sport", default: .run)
    var sport: AppIntentMonthlyWidgetSportType
    
    @Parameter(title: "Period", default: .last7days)
    var period: AppIntentAveragesType
}
