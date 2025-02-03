//
//  AppIntentSportType.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 31.05.2024.
//

import AppIntents

enum AppIntentSportType: String, AppEnum {
    case run, weighttraining, ride, walk, swim, hike, alpineski, badminton, backcountryski, canoeing, crossfit, elliptical, golf, iceskate, inlineskate, handcycle, highintensityintervaltraining, kayaking, kitesurf, nordicski, pickleball, pilates, racquetball, rockclimbing, rollerski, rowing, sail, skateboard, snowboard, snowshoe, soccer, squash, standuppaddling, stairstepper, surfing, tabletennis, tennis, velomobile, windsurf, wheelchair, workout, yoga
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Sports"
    static var caseDisplayRepresentations: [AppIntentSportType : DisplayRepresentation] = [
        .run: "Run",
        .ride: "Ride",
        .swim: "Swim",
        .walk: "Walk",
        .hike: "Hike",
        .rowing: "Rowing",
        .weighttraining: "WeightTraining",
        .alpineski: "AlpineSki",
        .badminton: "Badminton",
        .backcountryski: "BackcountrySki",
        .canoeing: "Canoeing",
        .crossfit: "Crossfit",
        .elliptical: "Elliptical",
        .golf: "Golf",
        .iceskate: "IceSkate",
        .inlineskate: "InlineSkate",
        .handcycle: "Handcycle",
        .highintensityintervaltraining: "HighIntensityIntervalTraining",
        .kayaking: "Kayaking",
        .kitesurf: "Kitesurf",
        .nordicski: "NordicSki",
        .pickleball: "Pickleball",
        .pilates: "Pilates",
        .racquetball: "Racquetball",
        .rockclimbing: "RockClimbing",
        .rollerski: "RollerSki",
        .rowing: "Rowing",
        .sail: "Sail",
        .skateboard: "Skateboard",
        .snowboard: "Snowboard",
        .snowshoe: "Snowshoe",
        .soccer: "Soccer",
        .squash: "Squash",
        .standuppaddling: "StandUpPaddling",
        .stairstepper: "StairStepper",
        .surfing: "Surfing",
        .tabletennis: "TableTennis",
        .tennis: "Tennis",
        .velomobile: "Velomobile",
        .windsurf: "Windsurf",
        .wheelchair: "Wheelchair",
        .workout: "Workout",
        .yoga: "Yoga",
    ]
    
    var defaultType: SportType {
        switch self {
        case .run:
            return .run
        case .ride:
            return .ride
        case .swim:
            return .swim
        case .walk:
            return .walk
        case .hike:
            return .hike
        case .rowing:
            return .rowing
        case .alpineski:
            return .alpineski
        case .weighttraining:
            return .weighttraining
        case .badminton:
            return .badminton
        case .backcountryski:
            return .backcountryski
        case .canoeing:
            return .canoeing
        case .crossfit:
            return .crossfit
        case .elliptical:
            return .elliptical
        case .golf:
            return .golf
        case .iceskate:
            return .iceskate
        case .inlineskate:
            return .inlineskate
        case .handcycle:
            return .handcycle
        case .highintensityintervaltraining:
            return .highintensityintervaltraining
        case .kayaking:
            return .kayaking
        case .kitesurf:
            return .kitesurf
        case .nordicski:
            return .nordicski
        case .pickleball:
            return .pickleball
        case .pilates:
            return .pilates
        case .racquetball:
            return .racquetball
        case .rockclimbing:
            return .rockclimbing
        case .rollerski:
            return .rollerski
        case .sail:
            return .sail
        case .skateboard:
            return .skateboard
        case .snowboard:
            return .snowboard
        case .snowshoe:
            return .snowshoe
        case .soccer:
            return .soccer
        case .squash:
            return .squash
        case .standuppaddling:
            return .standuppaddling
        case .stairstepper:
            return .stairstepper
        case .surfing:
            return .surfing
        case .tabletennis:
            return .tabletennis
        case .tennis:
            return .tennis
        case .velomobile:
            return .velomobile
        case .windsurf:
            return .windsurf
        case .wheelchair:
            return .wheelchair
        case .workout:
            return .workout
        case .yoga:
            return .yoga
        }
    }
}

enum AppIntentMonthlyWidgetSportType: String, AppEnum {
    case all, run, weighttraining, ride, walk, swim, hike, alpineski, badminton, backcountryski, canoeing, crossfit, elliptical, golf, iceskate, inlineskate, handcycle, highintensityintervaltraining, kayaking, kitesurf, nordicski, pickleball, pilates, racquetball, rockclimbing, rollerski, rowing, sail, skateboard, snowboard, snowshoe, soccer, squash, standuppaddling, stairstepper, surfing, tabletennis, tennis, velomobile, windsurf, wheelchair, workout, yoga
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Sports"
    static var caseDisplayRepresentations: [AppIntentMonthlyWidgetSportType : DisplayRepresentation] = [
        .all: "All Sports",
        .run: "Run",
        .ride: "Ride",
        .swim: "Swim",
        .walk: "Walk",
        .hike: "Hike",
        .rowing: "Rowing",
        .weighttraining: "WeightTraining",
        .alpineski: "AlpineSki",
        .badminton: "Badminton",
        .backcountryski: "BackcountrySki",
        .canoeing: "Canoeing",
        .crossfit: "Crossfit",
        .elliptical: "Elliptical",
        .golf: "Golf",
        .iceskate: "IceSkate",
        .inlineskate: "InlineSkate",
        .handcycle: "Handcycle",
        .highintensityintervaltraining: "HighIntensityIntervalTraining",
        .kayaking: "Kayaking",
        .kitesurf: "Kitesurf",
        .nordicski: "NordicSki",
        .pickleball: "Pickleball",
        .pilates: "Pilates",
        .racquetball: "Racquetball",
        .rockclimbing: "RockClimbing",
        .rollerski: "RollerSki",
        .rowing: "Rowing",
        .sail: "Sail",
        .skateboard: "Skateboard",
        .snowboard: "Snowboard",
        .snowshoe: "Snowshoe",
        .soccer: "Soccer",
        .squash: "Squash",
        .standuppaddling: "StandUpPaddling",
        .stairstepper: "StairStepper",
        .surfing: "Surfing",
        .tabletennis: "TableTennis",
        .tennis: "Tennis",
        .velomobile: "Velomobile",
        .windsurf: "Windsurf",
        .wheelchair: "Wheelchair",
        .workout: "Workout",
        .yoga: "Yoga",
    ]
    
    var defaultType: SportType {
        switch self {
        case .all:
            return .all
        case .run:
            return .run
        case .ride:
            return .ride
        case .swim:
            return .swim
        case .walk:
            return .walk
        case .hike:
            return .hike
        case .rowing:
            return .rowing
        case .alpineski:
            return .alpineski
        case .weighttraining:
            return .weighttraining
        case .badminton:
            return .badminton
        case .backcountryski:
            return .backcountryski
        case .canoeing:
            return .canoeing
        case .crossfit:
            return .crossfit
        case .elliptical:
            return .elliptical
        case .golf:
            return .golf
        case .iceskate:
            return .iceskate
        case .inlineskate:
            return .inlineskate
        case .handcycle:
            return .handcycle
        case .highintensityintervaltraining:
            return .highintensityintervaltraining
        case .kayaking:
            return .kayaking
        case .kitesurf:
            return .kitesurf
        case .nordicski:
            return .nordicski
        case .pickleball:
            return .pickleball
        case .pilates:
            return .pilates
        case .racquetball:
            return .racquetball
        case .rockclimbing:
            return .rockclimbing
        case .rollerski:
            return .rollerski
        case .sail:
            return .sail
        case .skateboard:
            return .skateboard
        case .snowboard:
            return .snowboard
        case .snowshoe:
            return .snowshoe
        case .soccer:
            return .soccer
        case .squash:
            return .squash
        case .standuppaddling:
            return .standuppaddling
        case .stairstepper:
            return .stairstepper
        case .surfing:
            return .surfing
        case .tabletennis:
            return .tabletennis
        case .tennis:
            return .tennis
        case .velomobile:
            return .velomobile
        case .windsurf:
            return .windsurf
        case .wheelchair:
            return .wheelchair
        case .workout:
            return .workout
        case .yoga:
            return .yoga
        }
    }
}
