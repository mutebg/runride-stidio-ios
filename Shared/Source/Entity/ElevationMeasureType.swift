//
//  ElevationMeasureType.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 30.05.2024.
//

import Foundation

enum ElevationMeasureType {
    case meter, foot
    
    static var current: ElevationMeasureType {
        let useMetric = !UserDefaultsConfig.useImperial
        return useMetric ? .meter : .foot
    }

    var title: String {
        switch self {
        case .meter:
            return "m"
        case .foot:
            return "ft"
        }
    }
}
