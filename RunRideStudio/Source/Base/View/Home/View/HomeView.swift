//
//  HomeView.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 30.05.2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    private var websiteUrl: URL? {
        let token = authViewModel.stravaToken ?? ""
        let id = authViewModel.stravaId ?? ""
        return URL(string: "https://runride.studio/ok?token=\(token)&id=\(id)")
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Section {
                    Grid(horizontalSpacing: Spacing.space16, verticalSpacing: .zero) {
                        GridRow {
                            HomeWidgetView(color: .cardBackground) {
                                GoalSmallCardView(
                                    metricType: .distance,
                                    intervalType: .monthly,
                                    currentValue: 150,
                                    goalValue: 200,
                                    activitiesCount: 12
                                )
                            }
                            .contextMenu {
                                Button(role: .destructive) {
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }

                            HomeWidgetView(color: .red) {
                                Text("Wednesday")
                                Text("5").font(.system(size: 33))
                                
                                Spacer()
                                
                                Text("No more events today")
                                    .multilineTextAlignment(.leading)
                            }
                        }
                        .aspectRatio(1.0, contentMode: .fill)
                    }
                    .padding(.zero)
                } header: {
                    Text("Goals")
                        .font(.subheadline)
                        .foregroundStyle(.textBrand1)
                        .opacity(0.7)
                        .padding(.horizontal, Spacing.space8)
                } footer: {
                    Spacer()
                        .frame(height: Spacing.space24)
                }

                Section {
                    Button {
                        guard let websiteUrl else { return }
                        UIApplication.shared.open(websiteUrl)
                    } label: {
                        HomeBigCardView(
                            title: "Discover more statistics on our website",
                            image: .website
                        )
                    }
                } header: {
                    Text("More")
                        .font(.subheadline)
                        .foregroundStyle(.textBrand1)
                        .opacity(0.7)
                        .padding(.horizontal, 8.0)
                }
            }
            .padding(16.0)
        }
    }
}

#Preview {
    ContentView()
}

//extension View {
//    func wiggling() -> some View {
//        modifier(WiggleModifier())
//    }
//}
//
//struct WiggleModifier: ViewModifier {
//    @State private var isWiggling = false
//    
//    private static func randomize(interval: TimeInterval, withVariance variance: Double) -> TimeInterval {
//        let random = (Double(arc4random_uniform(1000)) - 500.0) / 500.0
//        return interval + variance * random
//    }
//    
//    private let rotateAnimation = Animation
//        .easeInOut(
//            duration: WiggleModifier.randomize(
//                interval: 0.14,
//                withVariance: 0.025
//            )
//        )
//        .repeatForever(autoreverses: true)
//    
//    private let bounceAnimation = Animation
//        .easeInOut(
//            duration: WiggleModifier.randomize(
//                interval: 0.18,
//                withVariance: 0.025
//            )
//        )
//        .repeatForever(autoreverses: true)
//    
//    func body(content: Content) -> some View {
//        content
//            .rotationEffect(.degrees(isWiggling ? 2.0 : 0))
//            .animation(rotateAnimation)
//            .offset(x: 0, y: isWiggling ? 2.0 : 0)
//            .animation(bounceAnimation)
//            .onAppear() { isWiggling.toggle() }
//    }
//}
