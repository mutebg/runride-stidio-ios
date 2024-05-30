//
//  MonthAccessoryWidgetTimelineProvider.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 30.05.2024.
//

import WidgetKit

struct MonthAccessoryWidgetTimelineProvider: TimelineProvider {
    private let sportType: SportType
    private let networkService: WidgetServiceProtocol
    
    init(
        sportType: SportType,
        networkService: WidgetServiceProtocol = WidgetService()
    ) {
        self.sportType = sportType
        self.networkService = networkService
    }

    func placeholder(in context: Context) -> MonthAccessoryWidgetEntry {
        MonthAccessoryWidgetEntry(date: Date(), value: 100)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (MonthAccessoryWidgetEntry) -> Void) {
        completion(MonthAccessoryWidgetEntry(date: Date(), value: 100))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<MonthAccessoryWidgetEntry>) -> Void) {
        Task {
            let entry = await getData()
            completion(entry)
        }
    }
    
    private func getData() async -> Timeline<MonthAccessoryWidgetEntry> {
        let currentDate = Date() // Get the current date and time
        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)!
        
        let result = await networkService.getTotalMetricData(
            for: sportType.rawValue,
            interval: IntervalType.monthly.rawValue,
            metric: MetricType.distance.rawValue
        )
        
        switch result {
        case let .success(data):
            let entry = MonthAccessoryWidgetEntry(
                date: currentDate,
                value: data.currentValue
            )
            return Timeline(entries: [entry], policy: .after(nextUpdate))
        case .failure:
            let entry = MonthAccessoryWidgetEntry(date: currentDate, value: 0)
            return Timeline(entries: [entry], policy: .after(nextUpdate))
        }
    }
}
