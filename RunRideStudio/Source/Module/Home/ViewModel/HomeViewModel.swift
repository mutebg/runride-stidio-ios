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
    @Published var goalWidgetEntities: [HomeGoalWidgetEntity] = [
        HomeGoalWidgetEntity(
            id: UUID(),
            order: 0,
            sportType: .run,
            intervalType: .monthly,
            metricType: .distance,
            goal: 200
        ),
        HomeGoalWidgetEntity(
            id: UUID(),
            order: 1,
            sportType: .ride,
            intervalType: .weekly,
            metricType: .distance,
            goal: 14
        )
    ]

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
    
    func updateSnapshot() {
        Task {
            let data = await fetchSnapshotData(
                sportType: .run,
                intervalType: .monthly
            )
            
            guard let data else { return }

            self.snapshotWidgetEntity = .init(
                sportType: .run,
                intervalType: .monthly,
                snapshotTypes: [.activity, .time, .distance],
                data: data
            )
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
}
