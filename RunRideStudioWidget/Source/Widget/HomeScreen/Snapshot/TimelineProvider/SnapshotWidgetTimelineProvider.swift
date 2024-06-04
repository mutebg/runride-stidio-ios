//
//  SnapshotWidgetTimelineProvider.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 30.05.2024.
//

import WidgetKit

struct SnapshotWidgetTimelineProvider: AppIntentTimelineProvider {
    private let networkService: WidgetServiceProtocol
    
    init(networkService: WidgetServiceProtocol = WidgetService()) {
        self.networkService = networkService
    }

    func timeline(
        for configuration: SnapshotWidgetIntent,
        in context: Self.Context
    ) async -> Timeline<SnapshotWidgetEntry> {
        await snapshotData(for: configuration)
    }
    
    func placeholder(in context: Context) -> SnapshotWidgetEntry {
        SnapshotWidgetEntry(date: Date(), configuration: SnapshotWidgetIntent())
    }

    func snapshot(for configuration: SnapshotWidgetIntent, in context: Context) async -> SnapshotWidgetEntry {
        SnapshotWidgetEntry(date: Date(), configuration: configuration)
    }
    
    private func snapshotData(for configuration: Self.Intent) async -> Timeline<SnapshotWidgetEntry> {
        let currentDate = Date() // Get the current date and time
        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 2, to: currentDate)!
        
        let result = await networkService.getSnapshotData(
            sportType: configuration.sport.rawValue,
            interval: configuration.period.rawValue
        )
        
        switch result {
        case let .success(entity):
            let entry = SnapshotWidgetEntry(
                date: currentDate,
                entity: entity,
                configuration: configuration
            )
            return Timeline(entries: [entry], policy: .after(nextUpdate))
        case .failure:
            let entry = SnapshotWidgetEntry(
                date: currentDate,
                configuration: configuration
            )
            return Timeline(entries: [entry], policy: .after(nextUpdate))
        }
    }
}
