//
//  GoalWidgetTimelineProvider.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 30.05.2024.
//

import WidgetKit

struct MultiGoalWidgetTimelineProvider: AppIntentTimelineProvider {
    private let networkService: WidgetServiceProtocol
    
    init(networkService: WidgetServiceProtocol = WidgetService()) {
        self.networkService = networkService
    }

    func timeline(
        for configuration: MultiGoalWidgetIntent,
        in context: Self.Context
    ) async -> Timeline<MultiGoalWidgetEntry> {
        await goalData(for: configuration)
    }
    
    func placeholder(in context: Context) -> MultiGoalWidgetEntry {
        
        let intent = MultiGoalWidgetIntent()
        intent.goal = [200.0, 240, 200, 100]
        intent.sport = [.run, .ride, .swim, .hike]
        intent.period = .monthly
        intent.metric = .distance
        
        
        return MultiGoalWidgetEntry(date: Date(), value: [1200,150,100,100], activities: [8,3,5,1], configuration: intent)
    }

    func snapshot(for configuration: MultiGoalWidgetIntent, in context: Context) async -> MultiGoalWidgetEntry {
        
        configuration.goal = [200.0, 240, 200, 100];
        
        return MultiGoalWidgetEntry(date: Date(), value: [200,150,100,100], activities: [8,3,5,1], configuration: configuration)
    }
    
    private func goalData(for configuration: MultiGoalWidgetIntent) async -> Timeline<MultiGoalWidgetEntry> {
        let currentDate = Date() // Get the current date and time
        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 2, to: currentDate)!
        
        // Initialize empty arrays to store data
            var totalValues: [Double] = []
            var totalActivities: [Int] = []

            // Loop through each sport in the configuration
            for sport in configuration.sport {
                let result = await networkService.getTotalMetricData(
                    for: sport.rawValue,
                    interval: configuration.period.rawValue,
                    metric: configuration.metric.rawValue
                )

                switch result {
                case let .success(data):
                    totalValues.append(data.currentValue)
                    totalActivities.append(data.activitiesCount)
                case .failure:
                    // Handle failure case (add 0 values or log an error)
                    totalValues.append(0.0)
                    totalActivities.append(0)
                }
            }

            // Create the entry with accumulated data
            let entry = MultiGoalWidgetEntry(
                date: currentDate,
                value: totalValues, // Array of values for each sport
                activities: totalActivities, // Array of activity counts for each sport
                configuration: configuration
            )

            return Timeline(entries: [entry], policy: .after(nextUpdate))

    }
}
