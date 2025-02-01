//
//  BestEffortData.swift
//  RunRideStudio
//
//  Created by Stoyan Delev on 31.01.25.
//

struct BestEffortData: Decodable {
   
    let label: String
    let time: Double

    enum CodingKeys: String, CodingKey {
        
        case label = "label"
        case time = "time"
    }
}
