//
//  Double+Extension.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 30.05.2024.
//

import Foundation

extension Double {
    func formatted(maximumFractionDigits: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = maximumFractionDigits
        return formatter.string(from: self as NSNumber) ?? ""
    }
    
    var distanceInLocalSettings: Double {
        DistanceMeasureType.current == .km ? self : self * 0.621371
    }
    
    var elevationInLocalSettings: Double {
        ElevationMeasureType.current == .meter ? self : self * 3.28084
    }
    
    var secondsToHour: Double {
        self / 3600
    }
}
