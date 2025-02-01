//
//  WidgetTarget.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 27.05.2024.
//

import Foundation

enum WidgetTarget {
    case goalData(sportType: String, interval: String, metric: String)
    case snapshotData(sportType: String, interval: String)
    case gearData(gearID: String, interval: String, metric: String)
    case gearListData
    case monthlyData(sportType: String, interval: String, metric: String)
    case bestEfforts(sportType: String, interval: String)
}

extension WidgetTarget: BaseTarget {
    var path: String {
        switch self {
        case .goalData:
            return "/simple"
        case .snapshotData:
            return "/snapshot"
        case .gearData:
            return "/gear-data"
        case .gearListData:
            return "/gear-list"
        case .monthlyData:
            return "/calendar"
        case .bestEfforts:
            return "/bestefforts"
        }
    }
    
    var queryParameters: [String: String]? {
        switch self {
        case let .goalData(sportType, interval, metric):
            return [
                "type": sportType,
                "interval": interval,
                "metric": metric
            ]
        case let .snapshotData(sportType, interval):
            return [
                "type": sportType,
                "interval": interval,
                "full": "true"
            ]
        case let .gearData(gearID, interval, metric):
            return [
                "gear_id": gearID,
                "interval": interval,
                "metric": metric
            ]
        case .gearListData:
            return ["none": "none"]
            
        case let .monthlyData(sportType, interval, metric):
            return [
                "type": sportType,
                "interval": interval,
                "metric": metric
            ]
        
        case let .bestEfforts(sportType, interval):
            return [
                "type": sportType,
                "interval": interval,
            ]
        }
        
    }
}
