//
//  GoalWidgetView.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 30.05.2024.
//

import SwiftUI

struct GoalWidgetView: View {
    let useMetric = !UserDefaultsConfig.useImperial
    var entry: GoalWidgetTimelineProvider.Entry

    private var currentValue: Double {
        switch entry.configuration.metric {
        case .distance:
            return entry.value.distanceInLocalSettings
        case .time:
            return entry.value.secondsToHour
        case .elevation:
            return entry.value.elevationInLocalSettings
        }
    }
    
    private var currentMetric: String {
        switch entry.configuration.metric {
        case .distance:
            return useMetric ? "km" : "mi"
        case .time:
            return "h"
        case .elevation:
            return useMetric ? "m" : "ft"
        }
    }
    
    private var currentWordPeriod: String {
        entry.configuration.period.rawValue.lowercased().replacingOccurrences(of: "ly", with: "")
    }
    
    private var currentGoal: Double {
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

    var formatLenght: String {
        if ( currentValue > 9999 ) {
            return "%.0f"
        }
        return currentValue > 999 ? "%.1f" : "%.2f"
    }
   
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading, spacing: 5 ) {
            Text("This " + currentWordPeriod)
                .font(.system(size: 14))
                .foregroundColor(grayColor)
            Divider()
            Spacer()
            HStack(alignment: VerticalAlignment.bottom, spacing: 1){
                Text(String(format: formatLenght, currentValue))
                    .font(.system(size: 28) .bold())
                    .foregroundColor(.accentColor)
                Text(currentMetric)
                    .font(.system(size: 16))
                    .foregroundColor(.accentColor)
                    .padding(.bottom, 4)
                Spacer()
            }
            Text(String(entry.activities) + " " + acitivitiesLabel)
                .font(.system(size: 14))
                .foregroundColor(grayColor)
            Text(currentGoal > 0 ? String(goalPercent) + "% of the goal" : "No goal")
                .font(.system(size: 14))
                .foregroundColor(grayColor)
                .padding(.bottom, 4)
            
            ProgressView(value: progressPercent)
                .scaleEffect(x: 1.0, y: 3.0, anchor: .center)
                .tint(.accentColor)
                .padding(.bottom, 2)
        }
    }
}
