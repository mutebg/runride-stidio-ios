//
//  AppIntentSportType.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 31.05.2024.
//

import AppIntents

enum AppIntentSportType: String, AppEnum {
    case run, ride, swim, walk, hike, rowing

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Sports"
    static var caseDisplayRepresentations: [AppIntentSportType : DisplayRepresentation] = [
        .run: "Run",
        .ride: "Ride",
        .swim: "Swim",
        .walk: "Walk",
        .hike: "Hike",
        .rowing: "Rowing",
    ]
}
