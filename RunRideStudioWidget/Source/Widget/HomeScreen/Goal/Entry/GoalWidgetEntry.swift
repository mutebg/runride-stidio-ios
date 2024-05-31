//
//  GoalWidgetEntry.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 30.05.2024.
//

import WidgetKit

struct GoalWidgetEntry: TimelineEntry {
    let date: Date
    let value: Double
    let activities: Int
    let configuration: GoalWidgetIntent
}
