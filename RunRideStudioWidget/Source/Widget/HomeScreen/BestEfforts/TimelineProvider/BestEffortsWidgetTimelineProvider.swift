import WidgetKit

struct BestEffortsWidgetTimelineProvider: AppIntentTimelineProvider {
    private let networkService: WidgetServiceProtocol
    
    init(networkService: WidgetServiceProtocol = WidgetService()) {
        self.networkService = networkService
    }

    func timeline(
        for configuration: BestEffortsWidgetIntent,
        in context: Context
    ) async -> Timeline<BestEffortsWidgetEntry> {
        await bestEffortsData(for: configuration)
    }
    
    func placeholder(in context: Context) -> BestEffortsWidgetEntry {
        BestEffortsWidgetEntry(
            date: Date(),
            efforts: [
                BestEffortData(label: "5K", time: 1200),
                BestEffortData(label: "10K", time: 2400)
            ],
            configuration: BestEffortsWidgetIntent()
        )
    }

    func snapshot(for configuration: BestEffortsWidgetIntent, in context: Context) async -> BestEffortsWidgetEntry {
        BestEffortsWidgetEntry(
            date: Date(),
            efforts: [
                BestEffortData(label: "5K", time: 1200),
                BestEffortData(label: "10K", time: 2400)
            ],
            configuration: configuration
        )
    }
    
    private func bestEffortsData(for configuration: BestEffortsWidgetIntent) async -> Timeline<BestEffortsWidgetEntry> {
        let currentDate = Date()
        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 2, to: currentDate)!
        
        let result = await networkService.getBestEfforts(
            //for: configuration.sport.rawValue,
            for: "run",
            period: configuration.period.rawValue
        )
        
        switch result {
        case let .success(efforts):
            let entry = BestEffortsWidgetEntry(
                date: currentDate,
                efforts: efforts,
                configuration: configuration
            )
            return Timeline(entries: [entry], policy: .after(nextUpdate))
        case .failure:
            let entry = BestEffortsWidgetEntry(
                date: currentDate,
                efforts: [],
                configuration: configuration
            )
            return Timeline(entries: [entry], policy: .after(nextUpdate))
        }
    }
} 
