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
        ChartWidgetEntry(date: Date(), data: [], configuration: configuration)
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
