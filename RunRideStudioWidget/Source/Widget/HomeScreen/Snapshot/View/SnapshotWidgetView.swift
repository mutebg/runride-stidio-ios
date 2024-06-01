//
//  SnapshotWidgetView.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 30.05.2024.
//

import SwiftUI

struct SnapshotWidgetView: View {
    var entry: SnapshotWidgetTimelineProvider.Entry

    @Environment(\.widgetFamily) var widgetFamily
    let useMetric = !UserDefaultsConfig.useImperial
    
    var d: String {
        return getDistance(entry.entity?.distance ?? .zero, useMetric: useMetric)
    }
    var dd: String {
        return ((entry.entity?.distanceDifference ?? .zero) > 0 ? "+" : "" ) + getDistance(entry.entity?.distanceDifference ?? .zero, useMetric: useMetric)
    }
    var t: String {
        return getTime(entry.entity?.time ?? .zero)
    }
    var td: String {
        return ((entry.entity?.timeDifference ?? .zero) > 0 ? "+" : "" ) + getTime(entry.entity?.timeDifference ?? .zero)
    }
    var e: String {
        return getElevation(entry.entity?.elevation ?? .zero, useMetric: useMetric)
    }
    var ed: String {
        return ((entry.entity?.elevationDifference ?? .zero) > 0 ? "+" : "" ) + getElevation(entry.entity?.elevationDifference ?? .zero, useMetric: useMetric)
    }
    var a: String {
        return String(entry.entity?.activities ?? .zero)
    }
    var ad: String {
        return ((entry.entity?.activitiesDifference ?? .zero) > 0 ? "+" : "" ) +  String(entry.entity?.activitiesDifference ?? .zero)
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
                SnapshotItemView(label: "Distance", value: d, diff: dd, family: widgetFamily)
                Divider()
                SnapshotItemView(label: "Time", value: t, diff: td, family: widgetFamily)
            }
            
            Divider()
            
            HStack {
                SnapshotItemView(label: "Elevation", value: e, diff: ed, family: widgetFamily)
                Divider()
                SnapshotItemView(label: activities, value: a, diff: ad, family: widgetFamily)
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
    
    func getElevation(_ value: Double, useMetric: Bool) -> String {
       let convertedValue: Double = useMetric ? Double(value) : Double(value) * 3.28084
       return String(format: "%.2f", convertedValue) + (useMetric ? " m" : " ft")
    }
    
    func getTitle(_ sport: String, _ interval: String) -> String {
        let intervalWord = interval.lowercased().replacingOccurrences(of: "ly", with: "")
        return "This " + intervalWord + " " + sport.lowercased()
    }
}
