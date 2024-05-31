//
//  GoalSmallCardView.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 31.05.2024.
//

import SwiftUI

struct GoalSmallCardView: View {
    let metricType: MetricType
    let intervalType: IntervalType

    let currentValue: Double
    let goalValue: Double
    let activitiesCount: Int
    
    let useMetric = !UserDefaultsConfig.useImperial
       
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading, spacing: 5 ) {
            Text("This " + intervalType.title.lowercased())
                .font(.system(size: 14))
                .foregroundStyle(.textBrand1)
            Divider()
            Spacer()
            HStack(alignment: VerticalAlignment.bottom, spacing: 1){
                Text(value.formatted())
                    .font(.system(size: 28) .bold())
                    .foregroundColor(.brand2)
                Text(metricType.shortTitle)
                    .font(.system(size: 16))
                    .foregroundColor(.brand2)
                    .padding(.bottom, 4)
                Spacer()
            }
            Text(String(activitiesCount) + " " + acitivitiesLabel)
                .font(.system(size: 14))
                .foregroundStyle(.textBrand1)
            Text(goalValue > 0 ? String(goalPercent) + "% of the goal" : "No goal")
                .font(.system(size: 14))
                .foregroundStyle(.textBrand1)
                .padding(.bottom, 4)
            
            ProgressView(value: progressPercent)
                .scaleEffect(x: 1.0, y: 3.0, anchor: .center)
                .tint(.brand2)
                .padding(.bottom, 2)
        }
    }
}

// MARK: - Private methods
extension GoalSmallCardView {
    private var value: Double {
        switch metricType {
        case .distance:
            return currentValue.distanceInLocalSettings
        case .time:
            return currentValue.secondsToHour
        case .elevation:
            return currentValue.elevationInLocalSettings
        }
    }
    
    private var goalPercent: Int {
        let v = currentValue / ( goalValue / 100 )
        if  v.isNaN || v.isInfinite {
            return 0
        }
        return Int(v)
    }
    
    private var progressPercent: Double {
        let v = currentValue / goalValue;
        if v > 1 {
            return 1
        }
        if v == 0 {
            return 0.08
        }
        return v
    }
    
    private var acitivitiesLabel: String {
        activitiesCount > 1 ? "activities" : "activity"
    }
}
