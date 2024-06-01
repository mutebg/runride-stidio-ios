//
//  SnapshotData.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 27.05.2024.
//

import Foundation

struct SnapshotData: Decodable {
    private enum CodingKeys: String, CodingKey {
        case distance = "d"
        case distanceDifference = "dd"
        case time = "t"
        case timeDifference = "td"
        case elevation = "e"
        case elevationDifference = "ed"
        case activities = "a"
        case activitiesDifference = "ad"
    }

    let distance: Double
    let distanceDifference: Double
    let time: Int
    let timeDifference: Int
    let elevation: Double
    let elevationDifference: Double
    let activities: Int
    let activitiesDifference: Int
}
