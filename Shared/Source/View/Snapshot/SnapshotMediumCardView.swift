//
//  SnapshotMediumCardView.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 01.06.2024.
//

import SwiftUI

enum SnapshotDataType: String, Identifiable {
    var id: String {
        rawValue
    }
    
    case activity
    case time
    case distance
    case elevation
    
    var title: String {
        switch self {
        case .activity:
            return "Activities"
        case .time:
            return "Time"
        case .distance:
            return "Distance"
        case .elevation:
            return "Elevation"
        }
    }
}

struct SnapshotMediumCardView: View {
    let types: [SnapshotDataType]
    let sportType: SportType
    let intervalType: IntervalType
    let entity: SnapshotData

    var body: some View {
        VStack(alignment: .leading) {
            Text("your \(intervalType.rawValue) snapshot | \(sportType.title)".lowercased())
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundStyle(.textBrand1)
                .padding(.bottom, Spacing.space8)
            
            HStack(spacing: Spacing.space8) {
                ForEach(types) { type in
                    SnapshotItemView(
                        title: type.title,
                        value: formattedValueText(from: entity, for: type),
                        diff: formattedDifferenceText(from: entity, for: type),
                        isNegative: isDifferenceNegative(from: entity, for: type)
                    )
                    
                    if type != types.first, type != types.last {
                        Spacer()
                    }
                }
            }
        }
    }
}

// MARK: - Private methods
extension SnapshotMediumCardView {
    private func formattedValueText(
        from entity: SnapshotData,
        for type: SnapshotDataType
    ) -> String {
        switch type {
        case .activity:
            return entity.activities.description
        case .time:
            let absoluteSeconds = abs(entity.time)
            let (hours, remainingSeconds) = absoluteSeconds.quotientAndRemainder(dividingBy: 3600)
            let minutes = remainingSeconds / 60
            return String(format: "%dh %02dm", hours, minutes)
        case .distance:
            let value = entity.distance.distanceInLocalSettings
            return "\(value) \(DistanceMeasureType.current.title)"
        case .elevation:
            let value = entity.elevation.elevationInLocalSettings
            return "\(value) \(ElevationMeasureType.current.title)"
        }
    }
    
    private func formattedDifferenceText(
        from entity: SnapshotData,
        for type: SnapshotDataType
    ) -> String {
        switch type {
        case .activity:
            let value = abs(entity.activitiesDifference)
            guard value != .zero else { return "-" }
            return abs(entity.activitiesDifference).description
        case .time:
            let absoluteSeconds = abs(entity.timeDifference)
            guard absoluteSeconds != .zero else { return "-" }
            let (hours, remainingSeconds) = absoluteSeconds.quotientAndRemainder(dividingBy: 3600)
            let minutes = remainingSeconds / 60
            return String(format: "%dh %02dm", hours, minutes)
        case .distance:
            let value = abs(entity.distanceDifference.distanceInLocalSettings)
            guard value != .zero else { return "-" }
            return "\(value) \(DistanceMeasureType.current.title)"
        case .elevation:
            let value = abs(entity.elevationDifference.elevationInLocalSettings)
            guard value != .zero else { return "-" }
            return "\(value) \(ElevationMeasureType.current.title)"
        }
    }

    private func isDifferenceNegative(
        from entity: SnapshotData,
        for type: SnapshotDataType
    ) -> Bool? {
        let difference: Double

        switch type {
        case .activity:
            difference = Double(entity.activitiesDifference)
        case .time:
            difference = Double(entity.timeDifference)
        case .distance:
            difference = entity.distanceDifference
        case .elevation:
            difference = entity.elevationDifference
        }

        guard difference != 0 else {
            return nil
        }

        return difference < 0
    }

    private func getTime(_ seconds: Int) -> String {
        let sign = seconds < 0 ? "-" : ""
        let absoluteSeconds = abs(seconds)
        let (hours, remainingSeconds) = absoluteSeconds.quotientAndRemainder(dividingBy: 3600)
        let minutes = remainingSeconds / 60

        return String(format: "%@%dh %02dm", sign, hours, minutes)
    }
}

#Preview {
    SnapshotMediumCardView(
        types: [.activity, .distance, .time],
        sportType: .run,
        intervalType: .monthly,
        entity: SnapshotData(
            distance: 154.378,
            distanceDifference: 15.43,
            time: 45321,
            timeDifference: -5600,
            elevation: 10,
            elevationDifference: -4,
            activities: 7,
            activitiesDifference: .zero
        )
    )
    .frame(width: 340, height: 160)
}
