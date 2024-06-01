//
//  MetricType.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 31.05.2024.
//

import Foundation

enum MetricType: String, CaseIterable {
    case distance, time, elevation

    var shortTitle: String {
        switch self {
        case .distance:
            return DistanceMeasureType.current.title
        case .time:
            return "h"
        case .elevation:
            return ElevationMeasureType.current.title
        }
    }
}
