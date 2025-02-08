//
//  GoalWidgetTimelineProvider.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 30.05.2024.
//

import WidgetKit

struct AveragesWidgetTimelineProvider: AppIntentTimelineProvider {
    private let networkService: WidgetServiceProtocol
    
    init(networkService: WidgetServiceProtocol = WidgetService()) {
        self.networkService = networkService
    }

    func timeline(
        for configuration: AveragesWidgetIntent,
        in context: Self.Context
    ) async -> Timeline<AveragesWidgetEntry> {
        await averagesData(for: configuration)
    }
    
    func placeholder(in context: Context) -> AveragesWidgetEntry {
        AveragesWidgetEntry(date: Date(), distance: 8, totalElevationGain: 38, movingTime: 8000, activities: 5, configuration: AveragesWidgetIntent())
    }

    func snapshot(for configuration: AveragesWidgetIntent, in context: Context) async -> AveragesWidgetEntry {
        AveragesWidgetEntry(date: Date(), distance: 8, totalElevationGain: 28, movingTime: 4200, activities: 5, configuration: configuration)
    }
    
    private func averagesData(for configuration: AveragesWidgetIntent) async -> Timeline<AveragesWidgetEntry> {
        let currentDate = Date() // Get the current date and time
        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 2, to: currentDate)!
        
        let result = await networkService.getAveragesData(
            for: configuration.sport.rawValue,
            interval: configuration.period.rawValue
        )
        
        switch result {
        case let .success(data):
            let entry = AveragesWidgetEntry(
                date: currentDate,
                distance: data.distance,
                totalElevationGain: data.totalElevationGain,
                movingTime: data.movingTime,
                activities: data.activities,
                configuration: configuration
            )
            return Timeline(entries: [entry], policy: .after(nextUpdate))
        case .failure:
            let entry = AveragesWidgetEntry(date: currentDate, distance: 0, totalElevationGain: 0, movingTime: 0, activities: 0, configuration: configuration)
            return Timeline(entries: [entry], policy: .after(nextUpdate))
        }
    }
}
