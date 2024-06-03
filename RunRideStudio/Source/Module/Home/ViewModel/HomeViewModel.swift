//
//  HomeViewModel.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 31.05.2024.
//

import Foundation

struct HomeGoalWidgetEntity: Identifiable {
    let id: UUID
    let order: Int
    
    let sportType: SportType
    let intervalType: IntervalType
    let metricType: MetricType
    let goal: Double
}

struct HomeSnapshotWidgetEntity {
    let sportType: SportType
    let intervalType: IntervalType
    let snapshotTypes: [SnapshotDataType]
}

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var snapshotWidgetEntity: HomeSnapshotWidgetEntity?
    @Published var goalWidgetEntities: [HomeGoalWidgetEntity] = []
    @Published var selectedGoalWidgetEntity: HomeGoalWidgetEntity?

    private let stravaId: String?
    private let stravaToken: String?
    private let widgetDataService: WidgetServiceProtocol
    
    private var datas: [SnapshotData] = []

    init(widgetDataService: WidgetServiceProtocol = WidgetService()) {
        self.stravaId = UserDefaultsConfig.stravaId
        self.stravaToken = UserDefaultsConfig.stravaToken
        self.widgetDataService = widgetDataService
        
        self.updateData()
    }
}

// MARK: - Public methods
extension HomeViewModel {
    var websiteUrl: URL? {
        let token = stravaToken ?? ""
        let id = stravaId ?? ""
        return URL(string: "https://runride.studio/ok?token=\(token)&id=\(id)")
    }
    
    func value(
        for sportType: SportType,
        intervalType: IntervalType,
        metricType: MetricType
    ) -> Double {
        let data = datas.first { $0.sport == sportType && $0.period == intervalType }
        
        guard let data else { return .zero }
        
        switch metricType {
        case .distance:
            return data.distance
        case .time:
            return Double(data.time)
        case .elevation:
            return data.elevation
        }
    }
    
    func activitiesCount(
        for sportType: SportType,
        intervalType: IntervalType
    ) -> Int {
        let data = datas.first { $0.sport == sportType && $0.period == intervalType }
        return data?.activities ?? .zero
    }
    
    func snapshotData(
        for sportType: SportType?,
        intervalType: IntervalType?
    ) -> SnapshotData? {
        guard let sportType, let intervalType else { return nil }
        return datas.first { $0.sport == sportType && $0.period == intervalType }
    }

    func updateData() {
        Task {
            async let asyncSnapshot = fetchUserSnapshotWidget()
            async let asyncGoals = fetchUserGoalWidgets()
            
            let (snapshot, goals) = await (asyncSnapshot, asyncGoals)
            await fetchData()

            self.snapshotWidgetEntity = snapshot
            self.goalWidgetEntities = goals
        }
    }
}

// MARK: - Private methods
extension HomeViewModel {
    private func fetchUserSnapshotWidget() async -> HomeSnapshotWidgetEntity? {
        let snapshot = HomeSnapshotWidgetEntity(
            sportType: .run,
            intervalType: .monthly,
            snapshotTypes: [.time, .activity, .elevation]
        )
        return snapshot
    }

    private func fetchUserGoalWidgets() async -> [HomeGoalWidgetEntity] {
        let goals = [
            HomeGoalWidgetEntity(
                id: UUID(),
                order: 0,
                sportType: .run,
                intervalType: .weekly,
                metricType: .distance,
                goal: 50
            ),
            HomeGoalWidgetEntity(
                id: UUID(),
                order: 1,
                sportType: .ride,
                intervalType: .monthly,
                metricType: .elevation,
                goal: 100
            )
        ]
        return goals
    }
    
    private func fetchData() async {
        async let runWeekly = fetchSnapshotData(sportType: .run, intervalType: .weekly)
        async let runMonthly = fetchSnapshotData(sportType: .run, intervalType: .monthly)
        async let rideMonthly = fetchSnapshotData(sportType: .ride, intervalType: .monthly)
        
        let results = await [runWeekly, runMonthly, rideMonthly]
        self.datas = results.compactMap { $0 }
    }
    
    private func fetchSnapshotData(
        sportType: SportType,
        intervalType: IntervalType
    ) async -> SnapshotData? {
        let result = await widgetDataService.getSnapshotData(
            sportType: sportType.rawValue,
            interval: intervalType.rawValue
        )
        
        switch result {
        case let .success(entity):
            return entity
        case .failure:
            return nil
        }
    }
}
