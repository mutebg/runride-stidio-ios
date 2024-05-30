//
//  Date+Extension.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 30.05.2024.
//

import Foundation

extension Date {
    var shortMonth: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: self)
    }
}
