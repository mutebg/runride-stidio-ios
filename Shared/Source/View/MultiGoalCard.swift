import SwiftUI

struct MultiGoalCard: View {
    let sportType: [SportType]
    let metricType: MetricType
    let intervalType: IntervalType

    let currentValue: [Double]
    let goalValue: [Double]
    let activitiesCount: [Int]

    var body: some View {
        VStack(alignment: .leading) {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(Array(sportType.enumerated()), id: \.offset) { index, sport in
                    
                    VStack(alignment: .leading) {
                        
                        Text(sport.title)
                            .font(.footnote)
                            .foregroundStyle(.textBrand1)
                        
                        HStack(alignment: .bottom, spacing: Spacing.space2) {
                            Text( value( currentValue[index], for: metricType).formatted() )
                                .font(.title3)
                                .fontWeight(.black)
                                .minimumScaleFactor(0.5)
                                .foregroundColor(.accent)
                            
                            Text(metricType.shortTitle)
                                .font(.caption)
                                .foregroundStyle(.textBrand1)
                                .padding(.bottom, Spacing.space2)
                        }

                        Spacer()

//                        Text(String(activitiesCount[index]) + " activities")
//                            .font(.system(size: 14))
//                            .foregroundStyle(.textBrand1)
                        
                        if let item = goalValue[safe: index] {
                            if item > 0 {
                                ProgressView(value: progressPercent( currentValue[index], goalValue: item))
                                    .scaleEffect(x: 1.0, y: 1.0, anchor: .center)
                                    .tint(.accent)
                                //                            Text( String(item))
                                //                                .font(.footnote)
                                //                                .foregroundColor(.textBrand1)
                            }
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
        }
    }
}

extension MultiGoalCard {
    
    private func progressPercent(_ currentValue: Double, goalValue: Double) -> Double {
        min(currentValue / goalValue, 1)
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

extension Array {
    subscript(safe index: Index) -> Element? {
        guard index >= 0 && index < endIndex else { return nil }
        return self[index]
    }
}

#Preview {
    MultiGoalCard(
        sportType: [.run, .ride, .swim, .hike],
        metricType: .distance,
        intervalType: .monthly,
        currentValue: [150.654, 200, 100, 100],
        goalValue: [300, 300, 120],
        activitiesCount: [12, 19, 2, 5]
    )
    .frame(width: 320, height: 160)
}
