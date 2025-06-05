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
        interval: String,
        full: String
    ) async -> Result<SnapshotData, BaseNetworkError>
    func getGearData(
        for gerID: String,
        interval: String,
        metric: String
    ) async -> Result<TotalMetricData, BaseNetworkError>
    func getGears() async -> Result<[GearModel], BaseNetworkError>
    func getMonthlyData(
        for sportType: String,
        interval: String,
        metric: String
    ) async -> Result<[MonthlyStats], BaseNetworkError>
    func getBestEfforts(
        for sportType: String,
        period: String
    ) async -> Result<[BestEffortData], BaseNetworkError>
    func getAveragesData(
        for sportType: String,
        interval: String
    ) async -> Result<AveragesData, BaseNetworkError>
    func getTriathlonData(
        for interval: String,
    ) async -> Result<TriathlonData, BaseNetworkError>
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
        interval: String,
        full: String
    ) async -> Result<SnapshotData, BaseNetworkError> {
        let result = await provider.request(
            with: WidgetTarget.snapshotData(
                sportType: sportType,
                interval: interval,
                full: full
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
    
    
    func getGearData(
        for gearID: String,
        interval: String,
        metric: String
    ) async -> Result<TotalMetricData, BaseNetworkError> {
        let result = await provider.request(
            with: WidgetTarget.gearData(
                gearID: gearID,
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
    
    func getGears() async -> Result<[GearModel], BaseNetworkError> {
        let result = await provider.request(
            with: WidgetTarget.gearListData
        )
        
        switch result {
        case let .success(data):
            do {
                let response = try JSONDecoder().decode(GearsResponseModel.self, from: data)
                return .success(response.data ?? [])
            } catch let error {
                return .failure(.invalidData(error))
            }
        case let .failure(error):
            return .failure(error)
        }
    }
    
    func getMonthlyData(for sportType: String, interval: String, metric: String) async -> Result<[MonthlyStats], BaseNetworkError> {
        let result = await provider.request(
            with: WidgetTarget.monthlyData(
                sportType: sportType,
                interval: interval,
                metric: metric
            )
        )
        
        switch result {
            case let .success(data):
                do {
                    let response = try JSONDecoder().decode([MonthlyStats].self, from: data)
                    return .success(response)
                } catch let error {
                    return .failure(.invalidData(error))
                }
            case let .failure(error):
                return .failure(error)
            }
    }
    
    func getBestEfforts(
        for sportType: String,
        period: String
    ) async -> Result<[BestEffortData], BaseNetworkError> {
        let result = await provider.request(
            with: WidgetTarget.bestEfforts(
                sportType: sportType,
                interval: period
            )
        )
        
        switch result {
        case let .success(data):
            do {
                let response = try JSONDecoder().decode([BestEffortData].self, from: data)
                return .success(response)
            } catch let error {
                return .failure(.invalidData(error))
            }
        case let .failure(error):
            return .failure(error)
        }
    }
    
    func getAveragesData(
        for sportType: String,
        interval: String
    ) async -> Result<AveragesData, BaseNetworkError> {
        let result = await provider.request(
            with: WidgetTarget.averagesData(
                sportType: sportType,
                interval: interval
            )
        )

        switch result {
        case let .success(data):
            do {
                let response = try JSONDecoder().decode(AveragesData.self, from: data)
                return .success(response)
            } catch let error {
                return .failure(.invalidData(error))
            }
        case let .failure(error):
            return .failure(error)
        }
    }

    func getTriathlonData(
        for interval: String
    ) async -> Result<TriathlonData, BaseNetworkError> {
        let result = await provider.request(
            with: WidgetTarget.triathlonData(
                interval: interval
            )
        )

        switch result {
        case let .success(data):
            do {
                let response = try JSONDecoder().decode(TriathlonData.self, from: data)
                return .success(response)
            } catch let error {
                return .failure(.invalidData(error))
            }
        case let .failure(error):
            return .failure(error)
        }
    }
    
}
