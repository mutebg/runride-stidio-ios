//
//  MonthlyWidgetEntry.swift
//  RunRideStudio
//
//  Created by Stoyan Delev on 30.01.25.
//

import WidgetKit

struct MonthlyWidgetEntry: TimelineEntry {
    var date: Date
    let data: [MonthlyStats]
    let configuration: MonthlyWidgetIntent
}
