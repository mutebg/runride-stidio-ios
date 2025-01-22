//
//  TotalMetricData.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 30.05.2024.
//

import Foundation

struct GearData: Decodable {
    private enum CodingKeys: String, CodingKey {
        case currentValue = "v"
        case activitiesCount = "a"
    }

    let currentValue: Double
    let activitiesCount: Int
}
