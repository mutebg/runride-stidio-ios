//
//  SnapshotWidgetEntry.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 30.05.2024.
//

import WidgetKit

struct SnapshotWidgetEntry: TimelineEntry {
    let date: Date
    let d: Double
    let dd: Double
    let t: Int
    let td: Int
    let e: Int
    let ed: Int
    let a: Int
    let ad: Int
    let configuration: SnapshotWidgetIntent
    
    init(
        date: Date,
        d: Double = .zero,
        dd: Double = .zero,
        t: Int = .zero,
        td: Int = .zero,
        e: Int = .zero,
        ed: Int = .zero,
        a: Int = .zero,
        ad: Int = .zero,
        configuration: SnapshotWidgetIntent
    ) {
        self.date = date
        self.d = d
        self.dd = dd
        self.t = t
        self.td = td
        self.e = e
        self.ed = ed
        self.a = a
        self.ad = ad
        self.configuration = configuration
    }
}
