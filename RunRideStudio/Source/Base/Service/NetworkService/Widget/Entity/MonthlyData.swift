//
//  MonthlyData.swift
//  RunRideStudio
//
//  Created by Stoyan Delev on 30.01.25.
//

struct MonthlyStats: Decodable {
    let distance: Double
    let movingTime: Double
    let totalElevationGain: Double
    let date: String

    enum CodingKeys: String, CodingKey {
        case distance
        case movingTime = "moving_time"
        case totalElevationGain = "total_elevation_gain"
        case date
    }
}
