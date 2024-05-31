//
//  SportType.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 30.05.2024.
//

import AppIntents

enum SportType: String, AppEnum {
    case run, ride, swim, walk, hike, rowing

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Sports"
    static var caseDisplayRepresentations: [SportType : DisplayRepresentation] = [
        .run: "Run",
        .ride: "Ride",
        .swim: "Swim",
        .walk: "Walk",
        .hike: "Hike",
        .rowing: "Rowing",
    ]
}
