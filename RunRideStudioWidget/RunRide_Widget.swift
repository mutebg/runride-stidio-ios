//
//  RunRide_Widget.swift
//  RunRide Widget
//
//  Created by Stoyan Delev on 7.03.24.
//

import WidgetKit
import SwiftUI

struct ProviderGoal: AppIntentTimelineProvider {
    func timeline(
        for configuration: Self.Intent,
        in context: Self.Context
    ) async -> Timeline<SimpleEntry> {
        
        let currentDate = Date() // Get the current date and time
        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 2, to: currentDate)!
        
        do {
            let stravaData = try  await ApiFetcher.fetchData(
                sport: configuration.sport.rawValue,
                interval: configuration.period.rawValue,
                metric: configuration.metric.rawValue
            )
                        
            let entry = SimpleEntry(date: currentDate, value: stravaData.v, activities: stravaData.a, configuration: configuration)
            return Timeline(entries: [entry], policy: .after(nextUpdate))
        } catch {
            let entry = SimpleEntry(date: currentDate, value: 0, activities: 0, configuration: configuration)
            return Timeline(entries: [entry], policy: .after(nextUpdate))
        }
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), value: 5100, activities: 8, configuration: ConfigurationAppIntentGoal())
    }

    func snapshot(for configuration: ConfigurationAppIntentGoal, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), value: 5100, activities: 8, configuration: configuration)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let value: Double
    let activities: Int
    let configuration: ConfigurationAppIntentGoal
}

struct RunRide_WidgetEntryView : View {
    let useMetric = !UserDefaults(suiteName: "group.runride_studio")!.bool(forKey: "useImperial")
    var entry: ProviderGoal.Entry
    var value: Double {
        return entry.value
    }
    
   

    var currentValue: Double {
        switch entry.configuration.metric.rawValue {
            case "distance": return getDistance(value, useMetric: useMetric)
            case "time": return getTime(value)
            case "elevation": return getElevation(value, useMetric: useMetric)
            default: return 0
        }
    }
    
    var currentMetric: String {
        switch entry.configuration.metric.rawValue {
            case "distance": return useMetric ? "km" : "ml"
            case "time": return "h"
            case "elevation": return useMetric ? "m" : "ft"
            default: return ""
        }
    }
    
    var currentWordPeriod: String {
        entry.configuration.period.rawValue.lowercased().replacingOccurrences(of: "ly", with: "")
    }
    
    var currentGoal: Double {
        entry.configuration.goal
    }
    
    //let grayColor = Color(red: 0.3, green: 0.3, blue: 0.3);
    let grayColor = Color(.label);
    
    var goalPercent: Int {
        let v = currentValue / ( currentGoal / 100 )
        if  v.isNaN || v.isInfinite {
            return 0
        }
        return Int(v)
    }
    
    var progressPercent: Double {
        let v = currentValue / currentGoal;
        if v > 1 {
            return 1
        }
        if v == 0 {
            return 0.08
        }
        return v
    }
    
    
    var acitivitiesLabel: String {
        return entry.activities > 0 ? "activities" : "activity"
    }

   
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading, spacing: 5 ) {
            Text("This " + currentWordPeriod)
                .font(.system(size: 14))
                .foregroundColor(grayColor)
            Divider()
            Spacer()
            HStack(alignment: VerticalAlignment.bottom, spacing: 1){
                Text( String( currentValue ))
                    .font(.system(size: 28) .bold())
                    .foregroundColor(.accentColor)
                Text(currentMetric)
                    .font(.system(size: 16))
                    .foregroundColor(.accentColor)
                    .padding(.bottom, 4)
                Spacer()
            }
            Text( String(entry.activities) + " " + acitivitiesLabel)
                .font(.system(size: 14))
                .foregroundColor(grayColor)
            Text( currentGoal > 0 ? String(goalPercent) + "% of the goal" : "No goal")
                .font(.system(size: 14))
                .foregroundColor(grayColor)
                .padding(.bottom, 4)
            
            ProgressView(value: progressPercent)
                .scaleEffect(x: 1.0, y: 3.0, anchor: .center)
                .tint(.accentColor)
                .padding(.bottom, 2)
        }
    }
    
    func getTime(_ value: Double) -> Double {
        return value / 3600  // 60 seconds * 60 minutes = 3600 seconds per hour
    }
    
    func getDistance(_ value: Double, useMetric: Bool) -> Double {
        return useMetric ? value : value * 0.621371
    }
    
    func getElevation(_ value: Double, useMetric: Bool) -> Double {
        return useMetric ? value : value * 3.28084
    }
}

struct RunRide_Widget: Widget {
    let kind: String = "RunRide_Widget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntentGoal.self, provider: ProviderGoal()) { entry in
            RunRide_WidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }.supportedFamilies([.systemSmall])
        
    }
}

extension ConfigurationAppIntentGoal {
    fileprivate static var runner: ConfigurationAppIntentGoal {
        let intent = ConfigurationAppIntentGoal()
        intent.goal = 200.0
        intent.sport = .run
        intent.period = .monthly
        intent.metric = .distance
        return intent
    }
    
    fileprivate static var ridder: ConfigurationAppIntentGoal {
        let intent = ConfigurationAppIntentGoal()
        intent.goal = 160.0
        intent.sport = .ride
        intent.period = .weekly
        intent.metric = .distance
        return intent
    }
}
//
//#Preview(as: .systemSmall) {
//    RunRide_Widget()
//} timeline: {
//    SimpleEntry(date: .now, value: 150, activities: 8, configuration: .runner)
//    SimpleEntry(date: .now, value: 120, activities: 8, configuration: .ridder)
//}
