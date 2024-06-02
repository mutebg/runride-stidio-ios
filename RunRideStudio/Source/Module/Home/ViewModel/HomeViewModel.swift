//
//  HomeViewModel.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 31.05.2024.
//

import Foundation

enum HomeWidgetType: String {
    case goal, snapshot
}

struct HomeGoalWidgetEntity: Identifiable {
    let id: UUID
    let order: Int
    
    let sportType: SportType
    let intervalType: IntervalType
    let metricType: MetricType
    let goal: Double
    
    let data: TotalMetricData
}

struct HomeSnapshotWidgetEntity {
    let sportType: SportType
    let intervalType: IntervalType
    let snapshotTypes: [SnapshotDataType]

    let data: SnapshotData
}

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var snapshotWidgetEntity: HomeSnapshotWidgetEntity?
    @Published var goalWidgetEntities: [HomeGoalWidgetEntity] = []

    private let stravaId: String?
    private let stravaToken: String?
    private let widgetDataService: WidgetServiceProtocol

    init(widgetDataService: WidgetServiceProtocol = WidgetService()) {
        self.stravaId = UserDefaultsConfig.stravaId
        self.stravaToken = UserDefaultsConfig.stravaToken
        self.widgetDataService = widgetDataService
    }
}

// MARK: - Public methods
extension HomeViewModel {
    var websiteUrl: URL? {
        let token = stravaToken ?? ""
        let id = stravaId ?? ""
        return URL(string: "https://runride.studio/ok?token=\(token)&id=\(id)")
    }

    func updateData() {
        Task {
            async let snapshot = fetchSnapshotData(
                sportType: .run,
                intervalType: .monthly
            )
            async let goal1 = fetchGoalData(
                sportType: .run,
                intervalType: .monthly,
                metricType: .distance
            )
            async let goal2 = fetchGoalData(
                sportType: .ride,
                intervalType: .monthly,
                metricType: .distance
            )

            let data = await (snapshot, goal1, goal2)
            
            if let entity = data.0 {
                self.snapshotWidgetEntity = .init(
                    sportType: .run,
                    intervalType: .monthly,
                    snapshotTypes: [.activity, .time, .distance],
                    data: entity
                )
            }
            
            if let ent1 = data.1, let ent2 = data.2 {
                self.goalWidgetEntities = [
                    HomeGoalWidgetEntity(
                        id: UUID(),
                        order: 0,
                        sportType: .run,
                        intervalType: .monthly,
                        metricType: .distance,
                        goal: 200,
                        data: ent1
                    ),
                    HomeGoalWidgetEntity(
                        id: UUID(),
                        order: 1,
                        sportType: .ride,
                        intervalType: .monthly,
                        metricType: .distance,
                        goal: 100,
                        data: ent2
                    )
                ]
            }
        }
    }
}

// MARK: - Private methods
extension HomeViewModel {
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
    
    private func fetchGoalData(
        sportType: SportType,
        intervalType: IntervalType,
        metricType: MetricType
    ) async -> TotalMetricData? {
        let result = await widgetDataService.getTotalMetricData(
            for: sportType.rawValue,
            interval: intervalType.rawValue,
            metric: metricType.rawValue
        )
        
        switch result {
        case let .success(entity):
            return entity
        case .failure:
            return nil
        }
    }
}
