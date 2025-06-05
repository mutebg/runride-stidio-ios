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
        if self >= 1000 {
            formatter.maximumFractionDigits = 0
        } else if self >= 100 {
            formatter.maximumFractionDigits = 1
        } else {
            formatter.maximumFractionDigits = maximumFractionDigits
        }
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

    var secondsToTimeString: String {
        let totalSeconds = Int(self)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60

        if ( hours > 0 ) {
            return String(format: "%dh %02dm", hours, minutes)
        }
        return String(format: "%02dm", minutes)
    }
}
