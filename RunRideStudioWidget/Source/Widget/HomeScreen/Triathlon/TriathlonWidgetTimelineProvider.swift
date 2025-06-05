//
//  TriathlonWidgetTimelineProvider.swift
//  RunRideStudio
//
//  Created by Stoyan Delev on 4.06.25.
//


import WidgetKit

struct TriathlonWidgetTimelineProvider: AppIntentTimelineProvider {
    private let networkService: WidgetServiceProtocol
    
    init(networkService: WidgetServiceProtocol = WidgetService()) {
        self.networkService = networkService
    }

    func timeline(
        for configuration: TriathlonWidgetIntent,
        in context: Self.Context
    ) async -> Timeline<TriathlonWidgetEntry> {
        await triathlonData(for: configuration)
    }
    
    func placeholder(in context: Context) -> TriathlonWidgetEntry {
        
        let data = TriathlonData(
                    swim: TriathlonData.TriathlonDiscipline(distance: 1.5, time: 900, activities: 1),
                    ride: TriathlonData.TriathlonDiscipline(distance: 40, time: 7200, activities: 2),
                    run: TriathlonData.TriathlonDiscipline(distance: 10, time: 3600, activities: 2)
                )
        
        return TriathlonWidgetEntry(date: Date(), data: data, configuration: TriathlonWidgetIntent())
    }

    func snapshot(for configuration: TriathlonWidgetIntent, in context: Context) async -> TriathlonWidgetEntry {
        
        let data = TriathlonData(
                    swim: TriathlonData.TriathlonDiscipline(distance: 1.5, time: 900, activities: 1),
                    ride: TriathlonData.TriathlonDiscipline(distance: 40, time: 7200, activities: 2),
                    run: TriathlonData.TriathlonDiscipline(distance: 10, time: 3600, activities: 2)
                )
        
        return TriathlonWidgetEntry(date: Date(), data: data, configuration: configuration)
    }
    
    private func triathlonData(for configuration: TriathlonWidgetIntent) async -> Timeline<TriathlonWidgetEntry> {
        let currentDate = Date() // Get the current date and time
        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 2, to: currentDate)!
        
        let result = await networkService.getTriathlonData(
            for: configuration.period.rawValue
        )
        
        switch result {
        case let .success(data):
            let entry = TriathlonWidgetEntry(
                date: currentDate,
                data: data,
                configuration: configuration
            )
            return Timeline(entries: [entry], policy: .after(nextUpdate))
        case .failure:
            let data = TriathlonData(
                        swim: TriathlonData.TriathlonDiscipline(distance: 0, time: 0, activities: 0),
                        ride: TriathlonData.TriathlonDiscipline(distance: 0, time: 0, activities: 0),
                        run: TriathlonData.TriathlonDiscipline(distance: 0, time: 0, activities: 0)
                    )

            
            let entry = TriathlonWidgetEntry(date: currentDate, data: data, configuration: configuration)
            return Timeline(entries: [entry], policy: .after(nextUpdate))
        }
    }
}
