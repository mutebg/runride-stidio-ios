//
//  HomeAddGoalWidgetView.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 01.06.2024.
//

import SwiftUI

struct HomeAddGoalWidgetView: View {
    var action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .fontWeight(.light)
                    .foregroundColor(.textBrand1.opacity(0.5))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 22)
                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [10]))
                    .foregroundColor(.textBrand1.opacity(0.5))
            )
        }
    }
}
