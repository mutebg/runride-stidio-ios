//
//  WidgetService.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 27.05.2024.
//

import Foundation

protocol WidgetServiceProtocol {
    func getTotalMetricData(
        for sportType: String,
        interval: String,
        metric: String
    ) async -> Result<TotalMetricData, BaseNetworkError>
    func getSnapshotData(
        sportType: String,
        interval: String
    ) async -> Result<SnapshotData, BaseNetworkError>
}

final class WidgetService {
    private let provider: BaseNetworkServiceProtocol
    
    init(provider: BaseNetworkServiceProtocol = BaseNetworkService.shared) {
        self.provider = provider
    }
}

// MARK: - WidgetServiceProtocol
extension WidgetService: WidgetServiceProtocol {
    func getTotalMetricData(
        for sportType: String,
        interval: String,
        metric: String
    ) async -> Result<TotalMetricData, BaseNetworkError> {
        let result = await provider.request(
            with: WidgetTarget.goalData(
                sportType: sportType,
                interval: interval,
                metric: metric
            )
        )
        
        switch result {
        case let .success(data):
            do {
                let entity = try JSONDecoder().decode(TotalMetricData.self, from: data)
                return .success(entity)
            } catch let error {
                return .failure(.invalidData(error))
            }
        case let .failure(error):
            return .failure(error)
        }
    }
    
    func getSnapshotData(
        sportType: String,
        interval: String
    ) async -> Result<SnapshotData, BaseNetworkError> {
        let result = await provider.request(
            with: WidgetTarget.snapshotData(
                sportType: sportType,
                interval: interval
            )
        )
        
        switch result {
        case let .success(data):
            do {
                var snapshotData = try JSONDecoder().decode(SnapshotData.self, from: data)
                snapshotData.sport = .init(rawValue: sportType)
                snapshotData.period = .init(rawValue: interval)
                return .success(snapshotData)
            } catch let error {
                return .failure(.invalidData(error))
            }
        case let .failure(error):
            return .failure(error)
        }
    }
}
