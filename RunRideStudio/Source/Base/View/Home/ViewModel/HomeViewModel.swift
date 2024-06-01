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

final class HomeViewModel: ObservableObject {
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

    private var stravaId: String?
    private var stravaToken: String?
    
    init() {
        self.stravaId = UserDefaultsConfig.stravaId
        self.stravaToken = UserDefaultsConfig.stravaToken
    }
}

// MARK: - Public methods
extension HomeViewModel {
    var websiteUrl: URL? {
        let token = stravaToken ?? ""
        let id = stravaId ?? ""
        return URL(string: "https://runride.studio/ok?token=\(token)&id=\(id)")
    }
}
