//
//  TotalMetricData.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 30.05.2024.
//

import Foundation

struct TotalMetricData: Decodable {
    private enum CodingKeys: String, CodingKey {
        case currentValue = "v"
        case activitiesCount = "a"
    }

    let currentValue: Double
    let activitiesCount: Int
}

struct GearsResponseModel: Decodable {
    let data: [GearModel]?
}

struct GearModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case averageCadence = "average_cadence"
        case averageDistance = "average_distance"
        case averageElevationGain = "average_elevation_gain"
        case averageHeartrate = "average_heartrate"
        case averageMovingTime = "average_moving_time"
        case averageSpeed = "average_speed"
        case averageWatts = "average_watts"
        case gearID = "gear_id"
        case gearName = "gear_name"
        case latestDate = "latest_date"
        case startDate = "start_date"
        case totalActivities = "total_activities"
        case totalDistance = "total_distance"
        case totalElevationGain = "total_elevation_gain"
        case totalMovingTime = "total_moving_time"
        case usageDays = "usage_days"
    }

    let averageCadence: Double?
    let averageDistance: Double?
    let averageElevationGain: Double?
    let averageHeartrate: Double?
    let averageMovingTime: Double?
    let averageSpeed: Double?
    let averageWatts: Double?
    let gearID: String
    let gearName: String?
    let latestDate: String?
    let startDate: String?
    let totalActivities: Int?
    let totalDistance: Double?
    let totalElevationGain: Double?
    let totalMovingTime: Int?
    let usageDays: Int?

    init(
        averageCadence: Double? = nil,
        averageDistance: Double? = nil,
        averageElevationGain: Double? = nil,
        averageHeartrate: Double? = nil,
        averageMovingTime: Double? = nil,
        averageSpeed: Double? = nil,
        averageWatts: Double? = nil,
        gearID: String,
        gearName: String? = nil,
        latestDate: String? = nil,
        startDate: String? = nil,
        totalActivities: Int? = nil,
        totalDistance: Double? = nil,
        totalElevationGain: Double? = nil,
        totalMovingTime: Int? = nil,
        usageDays: Int? = nil
    ) {
        self.averageCadence = averageCadence
        self.averageDistance = averageDistance
        self.averageElevationGain = averageElevationGain
        self.averageHeartrate = averageHeartrate
        self.averageMovingTime = averageMovingTime
        self.averageSpeed = averageSpeed
        self.averageWatts = averageWatts
        self.gearID = gearID
        self.gearName = gearName
        self.latestDate = latestDate
        self.startDate = startDate
        self.totalActivities = totalActivities
        self.totalDistance = totalDistance
        self.totalElevationGain = totalElevationGain
        self.totalMovingTime = totalMovingTime
        self.usageDays = usageDays
    }
}
