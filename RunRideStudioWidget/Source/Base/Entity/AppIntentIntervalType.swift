//
//  AppIntentIntervalType.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 31.05.2024.
//

import AppIntents

enum AppIntentIntervalType: String, AppEnum {
    case weekly, monthly, yearly

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Intervals"
    static var caseDisplayRepresentations: [AppIntentIntervalType: DisplayRepresentation] = [
        .weekly: "Weekly",
        .monthly: "Monthly",
        .yearly: "Yearly",
    ]
    
    var defaultType: IntervalType {
        switch self {
        case .weekly:
            return .weekly
        case .monthly:
            return .monthly
        case .yearly:
            return .yearly
        }
    }
}

struct GearChoice: AppEntity {
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Gear"
    static var defaultQuery = GearQuery()
    
    var gearID: String
    var gearName: String
    
    var id: String { gearID }
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(gearName)")
    }
    
    static var defaultValue: GearChoice {
        GearChoice(gearID: "", gearName: "")
    }
}

struct GearQuery: EntityQuery {
    func entities(for identifiers: [String]) async throws -> [GearChoice] {
        guard let jsonString = UserDefaultsConfig.gears,
              let jsonData = jsonString.data(using: .utf8) else {
            return []
        }
        
        let gears = try JSONDecoder().decode([GearModel].self, from: jsonData)
        return gears.compactMap { gear in
            guard let name = gear.gearName else { return nil }
            return GearChoice(gearID: gear.gearID, gearName: name)
        }.filter { gear in
            identifiers.contains(gear.id)
        }
    }
    
    func suggestedEntities() async throws -> [GearChoice] {
        guard let jsonString = UserDefaultsConfig.gears,
              let jsonData = jsonString.data(using: .utf8) else {
            return []
        }
        
        let gears = try JSONDecoder().decode([GearModel].self, from: jsonData)
        return gears.compactMap { gear in
            guard let name = gear.gearName else { return nil }
            return GearChoice(gearID: gear.gearID, gearName: name)
        }
    }
}
