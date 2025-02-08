struct AveragesData: Decodable {
    let distance: Double
    let movingTime: Double
    let totalElevationGain: Double
    let activities: Double


    enum CodingKeys: String, CodingKey {
        case distance
        case movingTime = "moving_time"
        case totalElevationGain = "total_elevation_gain"
        case activities
    }
}
