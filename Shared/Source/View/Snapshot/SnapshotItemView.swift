//
//  SnapshotItemView.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 01.06.2024.
//

import SwiftUI

struct SnapshotItemView: View {
    let title: String
    let value: String
    let diff: String
    let isNegative: Bool?

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
                if isNegative != nil {
                    Image(systemName: currentImageName)
                        .font(.caption2)
                        .fontWeight(.medium)
                        .foregroundStyle(currentAccentColor)
                }

                Text(diff)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(currentAccentColor)
            }
            .padding(.horizontal, Spacing.space6)
            .padding(.vertical, Spacing.space4)
            .background(currentAccentColor.opacity(0.1))
            .clipShape(.rect(cornerRadius: 8))
        }
    }
}

// MARK: - Private methods
extension SnapshotItemView {
    private var currentImageName: String {
        guard let isNegative else { return "" }
        return isNegative ? "arrow.down" : "arrow.up"
    }

    private var currentAccentColor: Color {
        guard let isNegative else { return .textBrand1.opacity(0.7) }
        return isNegative ? .red : .accent
    }
}
