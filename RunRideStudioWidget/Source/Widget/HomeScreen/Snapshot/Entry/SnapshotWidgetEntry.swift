//
//  SnapshotWidgetEntry.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 30.05.2024.
//

import WidgetKit

struct SnapshotWidgetEntry: TimelineEntry {
    let date: Date
    let entity: SnapshotData?
    let configuration: SnapshotWidgetIntent
    
    init(
        date: Date,
        entity: SnapshotData? = nil,
        configuration: SnapshotWidgetIntent
    ) {
        self.date = date
        self.entity = entity
        self.configuration = configuration
    }
}
