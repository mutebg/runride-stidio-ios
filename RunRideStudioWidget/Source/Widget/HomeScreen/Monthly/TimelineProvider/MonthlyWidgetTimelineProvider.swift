//
//  MonthlyWidgetTimelineProvider.swift
//  RunRideStudio
//
//  Created by Stoyan Delev on 30.01.25.
//
import WidgetKit

struct MonthlyWidgetTimelineProvider: AppIntentTimelineProvider {
    private let networkService: WidgetServiceProtocol
    
    init(networkService: WidgetServiceProtocol = WidgetService()) {
        self.networkService = networkService
    }

    func timeline(
        for configuration: MonthlyWidgetIntent,
        in context: Self.Context
    ) async -> Timeline<MonthlyWidgetEntry> {
        await monthlyData(for: configuration)
    }
    
    func placeholder(in context: Context) -> MonthlyWidgetEntry {
        MonthlyWidgetEntry(date: Date(), data: [], configuration: MonthlyWidgetIntent())
    }

    func snapshot(for configuration: MonthlyWidgetIntent, in context: Context) async -> MonthlyWidgetEntry {
        let demoData = (1...31).map { day in
            MonthlyStats(
                distance: Double.random(in: 5000...25000),
                movingTime: Double.random(in: 3600...7200),
                totalElevationGain: Double.random(in: 10...100),
                date: String(format: "2024-01-%02d", day),
                emoji: nil
            )
        }
        return MonthlyWidgetEntry(date: Date(), data: demoData, configuration: configuration)
    }
    
    private func monthlyData(for configuration: MonthlyWidgetIntent) async -> Timeline<MonthlyWidgetEntry> {
        let currentDate = Date() // Get the current date and time
        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 2, to: currentDate)!
        
        let result = await networkService.getMonthlyData(
            for: configuration.sport.rawValue,
            interval: configuration.period.rawValue,
            metric: configuration.metric.rawValue
        )
        
        switch result {
        case let .success(data):
            let entry = MonthlyWidgetEntry(
                date: currentDate,
                data: data,
//                value: data.currentValue,
//                activities: data.activitiesCount,
                configuration: configuration
            )
            return Timeline(entries: [entry], policy: .after(nextUpdate))
        case .failure:
            let entry = MonthlyWidgetEntry(date: currentDate, data: [], configuration: configuration)
            return Timeline(entries: [entry], policy: .after(nextUpdate))
        }
    }
}
