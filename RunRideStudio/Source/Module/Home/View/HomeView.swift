//
//  HomeView.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 30.05.2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var viewModel = HomeViewModel()
    @State private var onEditGoalSectionMode: Bool = false

    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: Spacing.space16),
        GridItem(.flexible(), spacing: Spacing.space16)
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                snapshotSectionView
                goalsSectionView
                moreSectionView
            }
            .padding(Spacing.space20)
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .onAppear {
            viewModel.updateSnapshot()
        }
    }
}

// MARK: - Private methods
extension HomeView {
    @ViewBuilder
    private var snapshotSectionView: some View {
        if let entity = viewModel.snapshotWidgetEntity {
            Section {
                HomeWidgetView {
                    SnapshotMediumCardView(
                        types: entity.snapshotTypes,
                        sportType: entity.sportType,
                        intervalType: entity.intervalType,
                        entity: entity.data
                    )
                } onEdit: {
                } onDestroy: {
                }
            } footer: {
                Spacer()
                    .frame(height: Spacing.space24)
            }
        } else {
            EmptyView()
        }
    }

    private var goalsSectionView: some View {
        Section {
            LazyVGrid(columns: columns, spacing: Spacing.space16) {
                ForEach(viewModel.goalWidgetEntities) { entity in
                    HomeWidgetView {
                        GoalSmallCardView(
                            sportType: entity.sportType,
                            metricType: entity.metricType,
                            intervalType: entity.intervalType,
                            currentValue: 143.232,
                            goalValue: entity.goal,
                            activitiesCount: 12
                        )
                    } onEdit: {
                    } onDestroy: {
                    }
                    .aspectRatio(1.0, contentMode: .fill)
                }
                
                if onEditGoalSectionMode {
                    HomeAddGoalWidgetView() {
                        print("add new")
                    }
                    .aspectRatio(1.0, contentMode: .fill)
                }
            }
        } header: {
            HomeSectionHeaderView(title: "Goals") {
                onEditGoalSectionMode.toggle()
            }
        } footer: {
            Spacer()
                .frame(height: Spacing.space24)
        }
    }

    private var moreSectionView: some View {
        Section {
            Button {
                guard let url = viewModel.websiteUrl else { return }
                UIApplication.shared.open(url)
            } label: {
                HomeBigCardView(
                    title: "Discover more statistics on our website",
                    image: .website
                )
            }
            
            // Strava club card
            // FAQ cards: How to add widgets
        } header: {
            HomeSectionHeaderView(title: "More")
        } footer: {
            Spacer()
                .frame(height: Spacing.space24)
        }
    }
}

#Preview {
    RootView()
}
