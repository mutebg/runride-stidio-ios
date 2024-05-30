//
//  MetricType.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 30.05.2024.
//

import AppIntents

enum MetricType: String, AppEnum {
    case distance, time, elevation

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Metrics"
    static var caseDisplayRepresentations: [MetricType : DisplayRepresentation] = [
        .distance: "Distance",
        .time: "Time",
        .elevation: "Elevation",
    ]
}
