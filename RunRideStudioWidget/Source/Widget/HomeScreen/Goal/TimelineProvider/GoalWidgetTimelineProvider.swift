//
//  GoalWidgetTimelineProvider.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 30.05.2024.
//

import WidgetKit

struct GoalWidgetTimelineProvider: AppIntentTimelineProvider {
    private let networkService: WidgetServiceProtocol
    
    init(networkService: WidgetServiceProtocol = WidgetService()) {
        self.networkService = networkService
    }

    func timeline(
        for configuration: GoalWidgetIntent,
        in context: Self.Context
    ) async -> Timeline<GoalWidgetEntry> {
        await goalData(for: configuration)
    }
    
    func placeholder(in context: Context) -> GoalWidgetEntry {
        GoalWidgetEntry(date: Date(), value: 5100, activities: 8, configuration: GoalWidgetIntent())
    }

    func snapshot(for configuration: GoalWidgetIntent, in context: Context) async -> GoalWidgetEntry {
        GoalWidgetEntry(date: Date(), value: 5100, activities: 8, configuration: configuration)
    }
    
    private func goalData(for configuration: GoalWidgetIntent) async -> Timeline<GoalWidgetEntry> {
        let currentDate = Date() // Get the current date and time
        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 2, to: currentDate)!
        
        let result = await networkService.getGoalData(
            sportType: configuration.sport.rawValue,
            interval: configuration.period.rawValue,
            metric: configuration.metric.rawValue
        )
        
        switch result {
        case let .success(data):
            let entry = GoalWidgetEntry(
                date: currentDate,
                value: data.v,
                activities: data.a,
                configuration: configuration
            )
            return Timeline(entries: [entry], policy: .after(nextUpdate))
        case .failure:
            let entry = GoalWidgetEntry(date: currentDate, value: 0, activities: 0, configuration: configuration)
            return Timeline(entries: [entry], policy: .after(nextUpdate))
        }
    }
}
