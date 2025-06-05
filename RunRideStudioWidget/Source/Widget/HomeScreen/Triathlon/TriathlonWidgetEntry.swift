//
//  TriathlonWidgetEntry.swift
//  RunRideStudio
//
//  Created by Stoyan Delev on 4.06.25.
//
import WidgetKit

struct TriathlonWidgetEntry: TimelineEntry {
    let date: Date
    let data: TriathlonData
    let configuration: TriathlonWidgetIntent
}
