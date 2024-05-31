//
//  HomeView.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 30.05.2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var viewModel = HomeViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                goalsSectionView
                moreSectionView
            }
            .padding(16.0)
        }
    }
}

// MARK: - Private methods
extension HomeView {
    private var goalsSectionView: some View {
        Section {
            Grid(horizontalSpacing: Spacing.space16, verticalSpacing: .zero) {
                GridRow {
                    HomeWidgetView(color: .cardBackground) {
                        GoalSmallCardView(
                            sportType: .run,
                            metricType: .distance,
                            intervalType: .monthly,
                            currentValue: 150.767,
                            goalValue: 10,
                            activitiesCount: 12
                        )
                    } onEdit: {
                    } onDestroy: {
                    }

                    HomeWidgetView(color: .cardBackground) {
                        GoalSmallCardView(
                            sportType: .ride,
                            metricType: .distance,
                            intervalType: .monthly,
                            currentValue: 150.779,
                            goalValue: 0,
                            activitiesCount: 12
                        )
                    } onEdit: {
                    } onDestroy: {
                    }
                }
                .aspectRatio(1.0, contentMode: .fill)
            }
        } header: {
            HomeSectionHeaderView(title: "Goals") {
                print("edit")
            }
            .padding(.horizontal, Spacing.space8)
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
            HomeSectionHeaderView(title: "Goals")
                .padding(.horizontal, 8.0)
        } footer: {
            Spacer()
                .frame(height: Spacing.space24)
        }
    }
}

#Preview {
    ContentView()
}
