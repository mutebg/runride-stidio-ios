//
//  GoalSmallCardView.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 31.05.2024.
//

import SwiftUI

struct GearSmallCardView: View {
    let gearName: String
    let metricType: MetricType
    let intervalType: PeriodType

    let currentValue: Double
    let goalValue: Double
    let activitiesCount: Int
    

    var body: some View {
        VStack(alignment: .leading) {
            Text(headerText)
                .font(.footnote)
                .foregroundStyle(.textBrand1)
            
            HStack(alignment: .bottom, spacing: Spacing.space2) {
                Text(valueText)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.accent)
                Text(metricType.shortTitle)
                    .font(.caption)
                    .foregroundStyle(.textBrand1)
                    .padding(.bottom, Spacing.space6)
            }

            Spacer()

            Text(String(activitiesCount) + " " + acitivitiesLabel)
                .font(.system(size: 14))
                .foregroundStyle(.textBrand1)
            
            if goalValue > .zero {
                ProgressView(value: progressPercent)
                    .scaleEffect(x: 1.0, y: 1.0, anchor: .center)
                    .tint(.accent)
        
                Text(progressFooterText)
                    .font(.footnote)
                    .foregroundColor(.textBrand1)
            }
        }
        .frame(
          minWidth: 0,
          maxWidth: .infinity,
          minHeight: 0,
          maxHeight: .infinity,
          alignment: .topLeading
        )
    }
}

// MARK: - Private methods
extension GearSmallCardView {
    private var headerText: String {
        "\(gearName) | \(intervalType.title)"
    }
    
    private var valueText: String {
        currentValueFormatted.formatted()
    }

    private var currentValueFormatted: Double {
        value(currentValue, for: metricType)
    }

    private var progressPercent: Double {
        min(currentValue / goalValue, 1)
    }
    
    private var acitivitiesLabel: String {
        activitiesCount > 1 ? "activities" : "activity"
    }
    
    private var progressFooterText: String {
        let diff = max(goalValue - currentValueFormatted, 0)
        guard diff > 0 else {
            return "100%"
        }

        let diffText = diff.formatted()
        return "\(diffText) \(metricType.shortTitle) to goal"
    }
    
    private func value(_ value: Double, for type: MetricType) -> Double {
        switch type {
        case .distance:
            return value.distanceInLocalSettings
        case .time:
            return value.secondsToHour
        case .elevation:
            return value.elevationInLocalSettings
        }
    }
}

#Preview {
    GearSmallCardView(
        gearName: "Asics Superblast",
        metricType: .distance,
        intervalType: .alltime,
        currentValue: 342,
        goalValue: 600,
        activitiesCount: 12
    )
    .frame(width: 160, height: 160)
}
