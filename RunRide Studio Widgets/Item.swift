//
//  Item.swift
//  RunRide Studio Widgets
//
//  Created by Stoyan Delev on 3.03.24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
