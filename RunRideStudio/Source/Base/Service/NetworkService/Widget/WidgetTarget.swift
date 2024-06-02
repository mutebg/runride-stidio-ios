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
}

extension WidgetTarget: BaseTarget {
    var path: String {
        switch self {
        case .goalData:
            return "/simple"
        case .snapshotData:
            return "/snapshot"
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
        }
    }
}
