//
//  RunRide_WidgetBundle.swift
//  RunRide Widget
//
//  Created by Stoyan Delev on 7.03.24.
//

import WidgetKit
import SwiftUI

@main
struct RunRide_WidgetBundle: WidgetBundle {
    
    @WidgetBundleBuilder
    var body: some Widget {
        Snapshot()
        RunRide_Widget()
    }
}
