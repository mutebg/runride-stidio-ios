//
//  DistanceMeasureType.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 30.05.2024.
//

import Foundation

enum DistanceMeasureType {
    case km, mile
    
    static var current: DistanceMeasureType {
        let useMetric = !UserDefaultsConfig.useImperial
        return useMetric ? .km : .mile
    }

    var title: String {
        switch self {
        case .km:
            return "km"
        case .mile:
            return "mi"
        }
    }
}
