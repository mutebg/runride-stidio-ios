//
//  ChartWidgetTimelineProvider.swift
//  RunRideStudio
//
//  Created by Stoyan Delev on 3.02.25.
//
import WidgetKit

struct ChartWidgetTimelineProvider: AppIntentTimelineProvider {
    private let networkService: WidgetServiceProtocol
    
    init(networkService: WidgetServiceProtocol = WidgetService()) {
        self.networkService = networkService
    }

    func timeline(
        for configuration: ChartWidgetIntent,
        in context: Self.Context
    ) async -> Timeline<ChartWidgetEntry> {
        await monthlyData(for: configuration)
    }
    
    func placeholder(in context: Context) -> ChartWidgetEntry {
        ChartWidgetEntry(date: Date(), data: [], configuration: ChartWidgetIntent())
    }

    func snapshot(for configuration: ChartWidgetIntent, in context: Context) async -> ChartWidgetEntry {
        let demoData = (1...31).map { day in
            MonthlyStats(
                distance: Double.random(in: 5000...25000),
                movingTime: Double.random(in: 3600...7200),
                totalElevationGain: Double.random(in: 10...100),
                date: String(format: "2024-01-%02d", day),
                emoji: nil
            )
        }
        return ChartWidgetEntry(date: Date(), data: demoData, configuration: configuration)
    }
    
    private func monthlyData(for configuration: ChartWidgetIntent) async -> Timeline<ChartWidgetEntry> {
        let currentDate = Date() // Get the current date and time
        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 2, to: currentDate)!
        
        let result = await networkService.getMonthlyData(
            for: configuration.sport.rawValue,
            interval: configuration.period.rawValue,
            metric: "distance"
        )
        
        switch result {
        case let .success(data):
            let entry = ChartWidgetEntry(
                date: currentDate,
                data: data,
                configuration: configuration
            )
            return Timeline(entries: [entry], policy: .after(nextUpdate))
        case .failure:
            let entry = ChartWidgetEntry(date: currentDate, data: [], configuration: configuration)
            return Timeline(entries: [entry], policy: .after(nextUpdate))
        }
    }
}
