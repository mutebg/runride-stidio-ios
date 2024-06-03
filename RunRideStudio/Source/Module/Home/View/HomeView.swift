//
//  HomeView.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 30.05.2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var onEditGoalSectionMode: Bool = false
    @State private var showModal: Bool = false

    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: Spacing.space16),
        GridItem(.flexible(), spacing: Spacing.space16)
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                snapshotSectionView
                // TODO: - Add goals section
//                goalsSectionView
                moreSectionView
            }
            .padding(Spacing.space20)
        }
        .background(Color(uiColor: .systemGroupedBackground))
        
        .sheet(isPresented: $showModal) {
            if let entity = viewModel.selectedGoalWidgetEntity {
                HomeWidgetDetailView(
                    isPresented: $showModal,
                    viewModel: WidgetDetailViewModel(
                        sportType: entity.sportType,
                        intervalType: entity.intervalType,
                        metricType: entity.metricType,
                        goalValue: entity.goal
                    )
                )
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
            }
        }
    }
}

// MARK: - Private methods
extension HomeView {
    @ViewBuilder
    private var snapshotSectionView: some View {
        Section {
            HomeWidgetView {
                SnapshotMediumCardView(
                    types: viewModel.snapshotWidgetEntity?.snapshotTypes,
                    sportType: viewModel.snapshotWidgetEntity?.sportType,
                    intervalType: viewModel.snapshotWidgetEntity?.intervalType,
                    entity: viewModel.snapshotData(
                        for: viewModel.snapshotWidgetEntity?.sportType,
                        intervalType: viewModel.snapshotWidgetEntity?.intervalType
                    )
                )
            }
        } footer: {
            Spacer()
                .frame(height: Spacing.space24)
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
                            currentValue: viewModel.value(
                                for: entity.sportType,
                                intervalType: entity.intervalType,
                                metricType: entity.metricType
                            ),
                            goalValue: entity.goal,
                            activitiesCount: viewModel.activitiesCount(
                                for: entity.sportType,
                                intervalType: entity.intervalType
                            )
                        )
                    } 
                    .onEdit {
                        withAnimation {
                            viewModel.selectedGoalWidgetEntity = entity
                            showModal = true
                        }
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
                    image: .websiteCover
                )
            }
            
            Button {
                guard let url = viewModel.stravaClubUrl else { return }
                UIApplication.shared.open(url)
            } label: {
                HomeBigCardView(
                    title: "Join our\nStrava Club",
                    image: .stravaClubCover
                )
            }

            // TODO: - FAQ cards: How to add widgets
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
        .environmentObject(AuthViewModel())
        .environmentObject(SettingsViewModel())
}
