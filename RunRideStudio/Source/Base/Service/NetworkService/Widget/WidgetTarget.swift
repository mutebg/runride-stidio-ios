//
//  WidgetTarget.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 27.05.2024.
//

import Foundation

enum WidgetTarget {
    case goalData(sport: String, interval: String, metric: String)
    case snapshotData(sport: String, interval: String)
    case snapshots(sports: [String], intervals: [String])
}

extension WidgetTarget: BaseTarget {
    var path: String {
        switch self {
        case .goalData:
            return "/simple"
        case .snapshotData:
            return "/snapshot"
        case .snapshots:
            return "/snapshot"
        }
    }
    
    var queryParameters: [String: String]? {
        switch self {
        case let .goalData(sport, interval, metric):
            return [
                "type": sport,
                "interval": interval,
                "metric": metric
            ]
        case let .snapshotData(sport, interval):
            return [
                "type": sport,
                "interval": interval,
                "full": "true"
            ]
        case let .snapshots(sports, intervals):
            return [
                "type": sports.joined(separator: ","),
                "interval": intervals.joined(separator: ","),
                "full": "true",
                "multi": "true"
            ]
        }
    }
}
