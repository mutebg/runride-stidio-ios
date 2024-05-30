//
//  MonthAccessoryWidgetView.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 30.05.2024.
//

import SwiftUI

struct MonthAccessoryWidgetView: View {
    let entry: MonthAccessoryWidgetTimelineProvider.Entry
    let sportName: String

    private var month: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: entry.date).uppercased()
    }

    private var distance: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter.string(from: entry.value as NSNumber) ?? ""
    }

    private var metric: String {
        let useMetric = !UserDefaultsConfig.useImperial
        let metric = (useMetric ? "km" : "mi")
        return [metric, sportName].joined(separator: " | ").uppercased()
    }

    var body: some View {
        ZStack {
            Image(.halfFlower)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.55)

            VStack(alignment: .center) {
                Text(month)
                    .font(.system(size: 8))
                    .padding(.horizontal, Spacing.space8)
                Text(distance)
                    .font(.largeTitle)
                    .minimumScaleFactor(0.1)
                    .fontWeight(.black)
                Text(metric)
                    .font(.system(size: 8))
            }
            .padding(.init(
                top: Spacing.space8,
                leading: Spacing.space4,
                bottom: Spacing.space8,
                trailing: Spacing.space4
            ))
        }
    }
    
    func getDistance(_ value: Double) -> Double {
        let useMetric = !UserDefaultsConfig.useImperial
        return useMetric ? value : value * 0.621371
    }
}
