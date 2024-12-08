//
//  RootViewModel.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 01.06.2024.
//

import Foundation

final class RootViewModel: ObservableObject {
    enum Tab: Hashable {
        case overview
        case timeline
        case compare
        case settings
        
        var title: String {
            switch self {
            case .overview:
                return "Overview"
            case .timeline:
                return "Timeline"
            case .compare:
                return "Compare"
            case .settings:
                return "Settings"
            }
        }
        
        var imageName: String {
            switch self {
            case .overview:
                return "chart.line.uptrend.xyaxis.circle.fill"
            case .timeline:
                return "calendar.day.timeline.left"
            case .compare:
                return "signpost.right.and.left"
            case .settings:
                return "gearshape.fill"
            }
        }
    }

    @Published var selectedIndex: Tab = .overview
}

// MARK: - Public methods
extension RootViewModel {
    var formattedCurrentDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        return formatter.string(from: Date())
    }
}
