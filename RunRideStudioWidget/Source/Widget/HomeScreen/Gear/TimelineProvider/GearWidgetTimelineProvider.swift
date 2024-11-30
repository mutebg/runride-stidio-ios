//
//  GoalWidgetTimelineProvider.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 30.05.2024.
//

import WidgetKit

struct GearWidgetTimelineProvider: AppIntentTimelineProvider {
    private let networkService: WidgetServiceProtocol
    
    init(networkService: WidgetServiceProtocol = WidgetService()) {
        self.networkService = networkService
    }

    func timeline(
        for configuration: GearWidgetIntent,
        in context: Self.Context
    ) async -> Timeline<GearWidgetEntry> {
        await gearData(for: configuration)
    }
    
    func placeholder(in context: Context) -> GearWidgetEntry {
        GearWidgetEntry(date: Date(), value: 5100, activities: 8, configuration: GearWidgetIntent())
    }

    func snapshot(for configuration: GearWidgetIntent, in context: Context) async -> GearWidgetEntry {
        GearWidgetEntry(date: Date(), value: 5100, activities: 8, configuration: configuration)
    }
    
    private func gearData(for configuration: GearWidgetIntent) async -> Timeline<GearWidgetEntry> {
        let currentDate = Date() // Get the current date and time
        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 2, to: currentDate)!
        
        let result = await networkService.getGearData(
            for: configuration.gearID,
            interval: configuration.period.rawValue,
            metric: configuration.metric.rawValue
        )
        
        switch result {
        case let .success(data):
            let entry = GearWidgetEntry(
                date: currentDate,
                value: data.currentValue,
                activities: data.activitiesCount,
                configuration: configuration
            )
            return Timeline(entries: [entry], policy: .after(nextUpdate))
        case .failure:
            let entry = GearWidgetEntry(date: currentDate, value: 0, activities: 0, configuration: configuration)
            return Timeline(entries: [entry], policy: .after(nextUpdate))
        }
    }
}
