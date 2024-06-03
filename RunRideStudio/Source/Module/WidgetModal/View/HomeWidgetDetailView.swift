//
//  HomeWidgetDetailView.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 02.06.2024.
//

import SwiftUI

struct HomeWidgetDetailView: View {
    @Binding private var isPresented: Bool
    @StateObject private var viewModel: WidgetDetailViewModel

    init(isPresented: Binding<Bool>, viewModel: WidgetDetailViewModel) {
        self._isPresented = isPresented
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            List {
                widgetSectionView
                configurationSectionView
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Save") {
                isPresented = false
            })
        }
    }
}

// MARK: - Private methods
extension HomeWidgetDetailView {
    private var widgetSectionView: some View {
        Section {
            HStack {
                Spacer()
                
                HomeWidgetView {
                    GoalSmallCardView(
                        sportType: viewModel.selectedSportType,
                        metricType: viewModel.selectedMetricType,
                        intervalType: viewModel.selectedIntervalType,
                        currentValue: 0,
                        goalValue: viewModel.selectedGoalValue,
                        activitiesCount: 0
                    )
                }
                .frame(width: 160, height: 160)
                .aspectRatio(1.0, contentMode: .fill)
                
                Spacer()
            }
        }
        .listRowBackground(Color(uiColor: .systemGroupedBackground))
    }
    
    private var configurationSectionView: some View {
        Section {
            HStack {
                Text("Sport")

                Spacer()

                Menu {
                    Picker("Sport", selection: $viewModel.selectedSportType) {
                        ForEach(SportType.allCases) { type in
                            Text(type.title.capitalized)
                                .tag(type)
                        }
                    }
                } label: {
                    Text(viewModel.selectedSportType.title.capitalized)
                        .foregroundColor(.accent)
                }
            }
            
            HStack {
                Text("Time frame")

                Spacer()

                Menu {
                    Picker("Time frame", selection: $viewModel.selectedIntervalType) {
                        ForEach(IntervalType.allCases) { type in
                            Text(type.rawValue.capitalized)
                                .tag(type)
                        }
                    }
                } label: {
                    Text(viewModel.selectedIntervalType.rawValue.capitalized)
                        .foregroundColor(.accent)
                }
            }
            
            HStack {
                Text("Metric")

                Spacer()

                Menu {
                    Picker("Metric", selection: $viewModel.selectedMetricType) {
                        ForEach(MetricType.allCases) { type in
                            Text(type.rawValue.capitalized)
                                .tag(type)
                        }
                    }
                } label: {
                    Text(viewModel.selectedMetricType.rawValue.capitalized)
                        .foregroundColor(.accent)
                }
            }
            
            HStack {
                Text("Goal")

                Spacer()

                TextField("0", value: $viewModel.selectedGoalValue, format: .number)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
}
