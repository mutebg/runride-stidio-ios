//
//  SnapshotWidgetView.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 30.05.2024.
//

import SwiftUI

struct RunRideStudioWidgetEntryViewSnapshot: View {
    var entry: SnapshotWidgetTimelineProvider.Entry

    @Environment(\.widgetFamily) var widgetFamily
    let useMetric = !UserDefaultsConfig.useImperial
    
    var d: String {
        return getDistance(entry.d, useMetric: useMetric)
    }
    var dd: String {
        return ( entry.dd > 0 ? "+" : "" ) + getDistance(entry.dd, useMetric: useMetric)
    }
    var t: String {
        return getTime(entry.t)
    }
    var td: String {
        return ( entry.td > 0 ? "+" : "" ) + getTime(entry.td)
    }
    var e: String {
        return getElevation(entry.e, useMetric: useMetric)
    }
    var ed: String {
        return ( entry.dd > 0 ? "+" : "" ) + getElevation(entry.ed, useMetric: useMetric)
    }
    var a: String {
        return String(entry.a)
    }
    var ad: String {
        return (entry.ad > 0 ? "+" : "" ) +  String(entry.ad)
    }
    
    var title: String {
        return getTitle(entry.configuration.sport.rawValue, entry.configuration.period.rawValue )
    }
    
    var activities: String {
        return entry.configuration.sport.rawValue.capitalized + "s";
    }
   
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading, spacing: 4 ) {
            Text(title)
                .font(.system(size: 14))
            Divider()
            
            HStack  {
                SnapshotItem(label: "Distance", value: d, diff: dd, family: widgetFamily)
                Divider()
                SnapshotItem(label: "Time", value: t, diff: td, family: widgetFamily)
            }
            
            Divider()
            
            HStack {
                SnapshotItem(label: "Elevation", value: e, diff: ed, family: widgetFamily)
                Divider()
                SnapshotItem(label: activities, value: a, diff: ad, family: widgetFamily)
            }
        }
    }
    
    func getTime(_ seconds: Int) -> String {
        let showNegativeSign = seconds < 0
        let absoluteSeconds = abs(seconds) // Use abs() for absolute value

        let hours = absoluteSeconds / 3600
        let remainingSeconds = absoluteSeconds % 3600
        let minutes = remainingSeconds / 60

        let timeString = String(format: "%@%dh %02dm", showNegativeSign ? "-" : "", hours, minutes)
        return timeString
    }
    
    func getDistance(_ value: Double, useMetric: Bool) -> String {
        let convertedValue = useMetric ? value : value * 0.621371
        return String(format: "%.2f", convertedValue) + (useMetric ? "km" : "mi")
    }
    
    func getElevation(_ value: Int, useMetric: Bool) -> String {
       let convertedValue: Double = useMetric ? Double(value) : Double(value) * 3.28084
       return String(format: "%.2f", convertedValue) + (useMetric ? " m" : " ft")
    }
    
    func getTitle(_ sport: String, _ interval: String) -> String {
        let intervalWord = interval.lowercased().replacingOccurrences(of: "ly", with: "")
        return "This " + intervalWord + " " + sport.lowercased()
    }
}
