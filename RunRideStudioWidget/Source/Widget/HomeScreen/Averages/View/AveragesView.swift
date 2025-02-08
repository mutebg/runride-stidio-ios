import SwiftUI
import WidgetKit

struct AveragesView: View {
    let distance: Double
    let totalElevationGain: Double
    let movingTime: Double
    let activities: Double
    let sportType: SportType
    let periodType: PeriodType

    @Environment(\.widgetFamily) var widgetFamily
    let useMetric = !UserDefaultsConfig.useImperial
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading, spacing: 4 ) {
            Text("\(periodType.title) Avg")
                .font(.system(size: 14))
            Divider()
            
            HStack  {
                AveragesItemView(label: "Distance", value:  distance.distanceInLocalSettings.formatted() + " " + DistanceMeasureType.current.title, family: widgetFamily)
                Divider()
                AveragesItemView(label: "Time", value: movingTime.secondsToHour.formatted() + " h", family: widgetFamily)
            }
            
            Divider()
            
            HStack {
                AveragesItemView(label: "Elevation", value: totalElevationGain.elevationInLocalSettings.formatted() + " " + ElevationMeasureType.current.title, family: widgetFamily)
                Divider()
                AveragesItemView(label: "Activities", value: "\(activities.formatted(maximumFractionDigits: 1))", family: widgetFamily)
            }
        }
    }
    
 
}

struct AveragesItemView: View {
    let label: String
    let value: String
    let family: WidgetFamily

    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            HStack {
                Text(label)
                    .font(.system(size: family == .systemSmall ? 12 : 13 ))
                    .lineLimit(1)
                    .foregroundStyle(.textBrand1)
                    .truncationMode(.tail)
                
                Spacer()
            }
            Text(value)
                .font(.system(size: family == .systemSmall ? 14 : 18).bold())
                .foregroundColor(.accent)
        }.frame(maxWidth: .infinity)
    }
}



#Preview {
    AveragesView(
        distance: 42.5,
        totalElevationGain: 850,
        movingTime: 3600 * 2 + 1800, // 2h 30m
        activities: 5,
        sportType: .run,
        periodType: .last7days
    )
} 