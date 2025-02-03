//
//  SportType.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 31.05.2024.
//

import Foundation

enum SportType: String, CaseIterable, Identifiable, Codable {
    case all, run, weighttraining, ride, walk, swim, hike, alpineski, badminton, backcountryski, canoeing, crossfit, elliptical, golf, iceskate, inlineskate, handcycle, highintensityintervaltraining, kayaking, kitesurf, nordicski, pickleball, pilates, racquetball, rockclimbing, rollerski, rowing, sail, skateboard, snowboard, snowshoe, soccer, squash, standuppaddling, stairstepper, surfing, tabletennis, tennis, velomobile, windsurf, wheelchair, workout, yoga
    
    var title: String {
        switch self {
        case .all:
            return "All"
        case .run:
            return "Run"
        case .ride:
            return "Ride"
        case .swim:
            return "Swim"
        case .walk:
            return "Walk"
        case .hike:
            return "Hike"
        case .rowing:
            return "Rowing"
        case .weighttraining:
            return "WeightTraining"
        case .alpineski:
            return "AlpineSki"
        case .badminton:
            return "Badminton"
        case .backcountryski:
            return "BackcountrySki"
        case .canoeing:
            return "Canoeing"
        case .crossfit:
            return "Crossfit"
        case .elliptical:
            return "Elliptical"
        case .golf:
            return "Golf"
        case .iceskate:
            return "IceSkate"
        case .inlineskate:
            return "InlineSkate"
        case .handcycle:
            return "Handcycle"
        case .highintensityintervaltraining:
            return "HighIntensityIntervalTraining"
        case .kayaking:
            return "Kayaking"
        case .kitesurf:
            return "Kitesurf"
        case .nordicski:
            return "NordicSki"
        case .pickleball:
            return "Pickleball"
        case .pilates:
            return "Pilates"
        case .racquetball:
            return "Racquetball"
        case .rockclimbing:
            return "RockClimbing"
        case .rollerski:
            return "RollerSki"
        case .sail:
            return "Sail"
        case .skateboard:
            return "Skateboard"
        case .snowboard:
            return "Snowboard"
        case .snowshoe:
            return "Snowshoe"
        case .soccer:
            return "Soccer"
        case .squash:
            return "Squash"
        case .standuppaddling:
            return "StandUpPaddling"
        case .stairstepper:
            return "StairStepper"
        case .surfing:
            return "Surfing"
        case .tabletennis:
            return "TableTennis"
        case .tennis:
            return "Tennis"
        case .velomobile:
            return "Velomobile"
        case .windsurf:
            return "Windsurf"
        case .wheelchair:
            return "Wheelchair"
        case .workout:
            return "Workout"
        case .yoga:
            return "Yoga"
        }
    }
    var id: String {
        rawValue
    }
}
