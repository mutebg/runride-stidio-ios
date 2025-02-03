//
//  GridWidget.swift
//  RunRideStudio
//
//  Created by Stoyan Delev on 30.01.25.
//
import SwiftUI

struct GridWidget: View {
    
    let sportType: SportType
    let metricType: MetricType
    let periodType: PeriodType
    let data: [MonthlyStats]
    let showEmoji: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            let maxValue = getMaxValue(data, for: metricType)

            Text("\(periodType.title) | \(sportType.title)")
                .font(.footnote)
                .foregroundStyle(.textBrand1)
            
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 4), count: 7),
                spacing: 4
            ) {
                // Add empty views for offset based on first date's weekday
                if let firstDate = data.first?.date {
                    let dateFormatter: DateFormatter = {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd"
                        return formatter
                    }()
                    if let date = dateFormatter.date(from: firstDate) {
                        let calendar = Calendar.current
                        let weekday = calendar.component(.weekday, from: date)
                        // Adjust for weekday (1 = Sunday, so we need offset-1 spaces)
                        let offset = (weekday + 5) % 7 // Convert to 0 = Monday
                        ForEach(0..<offset, id: \.self) { _ in
                            Rectangle()
                                .fill(.clear)
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                }
                
                ForEach(data, id: \.date) { item in
                    let color = getColor(item, maxValue: maxValue, for: metricType)
                    
                    Rectangle()
                        .fill(color)
                        .overlay(
                            Group {
                                if showEmoji && item.emoji != nil {
                                    Text(item.emoji!)
                                } else {
                                    Text(item.date.suffix(2))
                                }
                            }
                            .font(.system(size: 12))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .foregroundStyle(.textBrand1)
                            .padding(1)
                        )
                        .aspectRatio(1, contentMode: .fit)
                        .overlay(
                            RoundedRectangle(cornerRadius: 2)
                                .stroke(color, lineWidth: 1)
                        )
                }
            }
        }.frame(maxWidth: .infinity, // Full Screen Width
            maxHeight: .infinity, // Full Screen Height
            alignment: .topLeading) // Align To top
    }

}

extension GridWidget {

    private func getMaxValue(_ values: [MonthlyStats], for type: MetricType) -> Double {
        let maxValue = values.map { value in
            switch type {
            case .distance:
                value.distance
            case .time:
                value.movingTime
            case .elevation:
                value.totalElevationGain
            }
        }.max() ?? 1.0
        return maxValue
    }

    private func getColor(_ value: MonthlyStats, maxValue: Double, for type: MetricType) -> Color {
        let currentValue = switch type {
        case .distance:
            value.distance
        case .time:
            value.movingTime
        case .elevation:
            value.totalElevationGain
        }
        
        var percentage = Double(currentValue) / Double(maxValue)

        if ( currentValue == 0 ) {
            percentage = 0
        }
        
        // GitHub-like color scheme
        let color = switch percentage {
        case 0:
            Color(uiColor: UIColor { traitCollection in
                traitCollection.userInterfaceStyle == .dark ? 
                    UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1) :
                    UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)
            })
        case 0..<0.25:
            Color(uiColor: UIColor { traitCollection in
                traitCollection.userInterfaceStyle == .dark ?
                    UIColor(red: 0.2, green: 0.4, blue: 0.2, alpha: 1) :
                    UIColor(red: 0.573, green: 0.816, blue: 0.482, alpha: 1)
            })
        case 0.25..<0.5:
            Color(uiColor: UIColor { traitCollection in
                traitCollection.userInterfaceStyle == .dark ?
                    UIColor(red: 0.25, green: 0.5, blue: 0.25, alpha: 1) :
                    UIColor(red: 0.365, green: 0.729, blue: 0.333, alpha: 1)
            })
        case 0.5..<0.75:
            Color(uiColor: UIColor { traitCollection in
                traitCollection.userInterfaceStyle == .dark ?
                    UIColor(red: 0.3, green: 0.6, blue: 0.3, alpha: 1) :
                    UIColor(red: 0.196, green: 0.612, blue: 0.157, alpha: 1)
            })
        default:
            Color(uiColor: UIColor { traitCollection in
                traitCollection.userInterfaceStyle == .dark ?
                    UIColor(red: 0.35, green: 0.7, blue: 0.35, alpha: 1) :
                    UIColor(red: 0.094, green: 0.478, blue: 0.063, alpha: 1)
            })
        }
        return color
    }
}


#Preview {
    GridWidget(
        sportType: .run,
        metricType: .distance,
        periodType: .last30days,
        
        data: [
            MonthlyStats(distance: 10, movingTime: 15, totalElevationGain: 3245, date: "2024-01-01", emoji: "🏃"),
            MonthlyStats(distance: 65, movingTime: 12, totalElevationGain: 2890, date: "2024-01-02", emoji: "🏃"),
            MonthlyStats(distance: 92, movingTime: 18, totalElevationGain: 3567, date: "2024-01-03", emoji: "🏃"),
            MonthlyStats(distance: 45, movingTime: 9, totalElevationGain: 1234, date: "2024-01-04", emoji: "🏃"),
            MonthlyStats(distance: 83, movingTime: 16, totalElevationGain: 4123, date: "2024-01-05", emoji: "🏃"),
            MonthlyStats(distance: 71, movingTime: 14, totalElevationGain: 2765, date: "2024-01-06", emoji: "🏃"),
            MonthlyStats(distance: 89, movingTime: 17, totalElevationGain: 3890, date: "2024-01-07", emoji: "🏃"),
            MonthlyStats(distance: 55, movingTime: 11, totalElevationGain: 2345, date: "2024-01-08", emoji: "🏃"),
            MonthlyStats(distance: 94, movingTime: 19, totalElevationGain: 4567, date: "2024-01-09", emoji: "🏃"),
            MonthlyStats(distance: 67, movingTime: 13, totalElevationGain: 2987, date: "2024-01-10", emoji: "🏃"),
            MonthlyStats(distance: 86, movingTime: 17, totalElevationGain: 3456, date: "2024-01-11", emoji: "🏃"),
            MonthlyStats(distance: 73, movingTime: 14, totalElevationGain: 3012, date: "2024-01-12", emoji: "🏃"),
            MonthlyStats(distance: 91, movingTime: 18, totalElevationGain: 4234, date: "2024-01-13", emoji: "🏃"),
            MonthlyStats(distance: 58, movingTime: 11, totalElevationGain: 2567, date: "2024-01-14", emoji: "🏃"),
            MonthlyStats(distance: 82, movingTime: 16, totalElevationGain: 3789, date: "2024-01-15", emoji: "🏃"),
            MonthlyStats(distance: 69, movingTime: 13, totalElevationGain: 2890, date: "2024-01-16", emoji: "🏃"),
            MonthlyStats(distance: 88, movingTime: 17, totalElevationGain: 3678, date: "2024-01-17", emoji: "🏃"),
            MonthlyStats(distance: 76, movingTime: 15, totalElevationGain: 3234, date: "2024-01-18", emoji: "🏃"),
            MonthlyStats(distance: 93, movingTime: 19, totalElevationGain: 4567, date: "2024-01-19", emoji: "🏃"),
            MonthlyStats(distance: 61, movingTime: 12, totalElevationGain: 2345, date: "2024-01-20", emoji: "🏃"),
            MonthlyStats(distance: 85, movingTime: 17, totalElevationGain: 3890, date: "2024-01-21", emoji: "🏃"),
            MonthlyStats(distance: 72, movingTime: 14, totalElevationGain: 3123, date: "2024-01-22", emoji: "🏃"),
            MonthlyStats(distance: 90, movingTime: 18, totalElevationGain: 4012, date: "2024-01-23", emoji: "🏃"),
            MonthlyStats(distance: 64, movingTime: 12, totalElevationGain: 2678, date: "2024-01-24", emoji: "🏃"),
            MonthlyStats(distance: 87, movingTime: 17, totalElevationGain: 3567, date: "2024-01-25", emoji: "🏃"),
            MonthlyStats(distance: 75, movingTime: 15, totalElevationGain: 3234, date: "2024-01-26", emoji: "🏃"),
            MonthlyStats(distance: 95, movingTime: 19, totalElevationGain: 4789, date: "2024-01-27", emoji: "🏃"),
            MonthlyStats(distance: 68, movingTime: 13, totalElevationGain: 2890, date: "2024-01-28", emoji: "🏃"),
            MonthlyStats(distance: 84, movingTime: 16, totalElevationGain: 3456, date: "2024-01-29", emoji: "🏃"),
            MonthlyStats(distance: 79, movingTime: 15, totalElevationGain: 3345, date: "2024-01-30", emoji: "🏃"),
        ],
        showEmoji: true
    )
    .frame(width: 160, height: 160)
}


