//
//  SnapshotMediumCardView.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 01.06.2024.
//

import SwiftUI

enum SnapshotDataType {
    case activity
    case time
    case distance
    case elevation
}

struct SnapshotMediumCardView: View {
    let types: [SnapshotDataType] = []

    var body: some View {
        VStack(alignment: .leading) {
            Text("your weekly snapshot | run")
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundStyle(.textBrand1)
                .padding(.bottom, Spacing.space8)
            
            HStack(spacing: Spacing.space8) {
                SnapshotItemView(title: "Activities", value: "7", diff: "3")
                
                Spacer()
                
                SnapshotItemView(title: "Time", value: "7h 30m", diff: "0h 30m")

                Spacer()

                SnapshotItemView(title: "Distance", value: "70,32 km", diff: "12,21 km")
            }
        }
    }
}

struct SnapshotItemView: View {
    let title: String
    let value: String
    let diff: String

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.space4) {
            Text(title)
                .font(.footnote)
                .foregroundStyle(.textBrand1.opacity(0.7))

            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.textBrand1)
            
            HStack {
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundStyle(.red)

                Text(diff)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.red)
            }
            .padding(Spacing.space4)
            .background(.red.opacity(0.1))
            .clipShape(.rect(cornerRadius: 8))

        }
    }
}

#Preview {
    SnapshotMediumCardView()
    .frame(width: 340, height: 160)
}
