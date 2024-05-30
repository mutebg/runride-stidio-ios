//
//  RunRideStudioWidgetBundle.swift
//  RunRideStudio
//
//  Created by Stoyan Delev on 7.03.24.
//

import SwiftUI
import WidgetKit

@main
struct RunRideStudioWidgetBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        SnapshotWidget()
        GoalWidget()
        RunMonthAccessoryWidget()
        RideMonthAccessoryWidget()
    }
}
