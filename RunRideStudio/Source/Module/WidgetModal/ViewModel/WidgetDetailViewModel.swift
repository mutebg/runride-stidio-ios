//
//  WidgetDetailViewModel.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 02.06.2024.
//

import Foundation

final class WidgetDetailViewModel: ObservableObject {
    @Published var selectedSportType: SportType
    @Published var selectedIntervalType: IntervalType
    @Published var selectedMetricType: MetricType
    @Published var selectedGoalValue: Double

    init(
        sportType: SportType,
        intervalType: IntervalType,
        metricType: MetricType,
        goalValue: Double
    ) {
        self.selectedSportType = sportType
        self.selectedIntervalType = intervalType
        self.selectedMetricType = metricType
        self.selectedGoalValue = goalValue
    }
}

// MARK: - Public methods
extension WidgetDetailViewModel {
}

// MARK: - Private methods
extension WidgetDetailViewModel {
}
