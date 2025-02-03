//
//  ChartWidgetEntry.swift
//  RunRideStudio
//
//  Created by Stoyan Delev on 3.02.25.
//

import WidgetKit

struct ChartWidgetEntry: TimelineEntry {
    var date: Date
    let data: [MonthlyStats]
    let configuration: ChartWidgetIntent
}
