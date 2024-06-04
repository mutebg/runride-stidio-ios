//
//  AppIntentMetricType.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 31.05.2024.
//

import AppIntents

enum AppIntentMetricType: String, AppEnum {
    case distance, time, elevation

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Metrics"
    static var caseDisplayRepresentations: [AppIntentMetricType : DisplayRepresentation] = [
        .distance: "Distance",
        .time: "Time",
        .elevation: "Elevation",
    ]
    
    var defaultType: MetricType {
        switch self {
        case .distance:
            return .distance
        case .time:
            return .time
        case .elevation:
            return .elevation
        }
    }
}
