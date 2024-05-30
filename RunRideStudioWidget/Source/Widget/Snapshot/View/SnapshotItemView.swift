//
//  SnapshotItemView.swift
//  RunRideStudioWidgetExtension
//
//  Created by Arman Turalin on 30.05.2024.
//

import SwiftUI
import WidgetKit

struct SnapshotItem: View {
    let label: String
    let value: String
    let diff: String
    let family: WidgetFamily

    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            HStack {
                Text(label).font(.system(size: family == .systemSmall ? 12 : 13 ))
                Spacer()
            }
            Text(value).font(.system(size: family == .systemSmall ? 14 : 18).bold())
                .foregroundColor(.accentColor)
            Text(diff).font(.system(size: family == .systemSmall ? 11 : 12 ))
        }.frame(maxWidth: .infinity)
    }
}
