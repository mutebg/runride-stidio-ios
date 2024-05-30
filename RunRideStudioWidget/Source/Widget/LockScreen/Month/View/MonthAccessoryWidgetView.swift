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

    private var metric: String {
        [DistanceMeasureType.current.title, sportName]
            .joined(separator: " | ").uppercased()
    }

    var body: some View {
        ZStack {
            Image(.flower)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.3)

            VStack(alignment: .center) {
                Text(entry.date.shortMonth.uppercased())
                    .font(.system(size: 8))
                Text(entry.value.distanceInLocalSettings.formatted())
                    .font(.largeTitle)
                    .minimumScaleFactor(0.01)
                    .lineLimit(1)
                    .fontWeight(.black)
                Text(metric)
                    .font(.system(size: 8))
            }
            .padding(.init(
                top: Spacing.space10,
                leading: Spacing.space8,
                bottom: Spacing.space10,
                trailing: Spacing.space8
            ))
        }
    }
}
