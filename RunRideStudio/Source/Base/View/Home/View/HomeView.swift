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
                                GoalWidgetView()
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

struct GoalWidgetView: View {
    let useMetric = !UserDefaultsConfig.useImperial

    private var currentValue: Double {
        return 150
    }
    
    private var currentMetric: String {
        "km"
    }
    
    private var currentWordPeriod: String {
        "weekly".lowercased().replacingOccurrences(of: "ly", with: "")
    }
    
    private var currentGoal: Double {
        200
    }
    
    //let grayColor = Color(red: 0.3, green: 0.3, blue: 0.3);
    let grayColor = Color(.label);
    
    var goalPercent: Int {
        let v = currentValue / ( currentGoal / 100 )
        if  v.isNaN || v.isInfinite {
            return 0
        }
        return Int(v)
    }
    
    var progressPercent: Double {
        let v = currentValue / currentGoal;
        if v > 1 {
            return 1
        }
        if v == 0 {
            return 0.08
        }
        return v
    }
    
    var acitivitiesLabel: String {
        return 12 > 0 ? "activities" : "activity"
    }

    var formatLenght: String {
        if ( currentValue > 9999 ) {
            return "%.0f"
        }
        return currentValue > 999 ? "%.1f" : "%.2f"
    }
   
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading, spacing: 5 ) {
            Text("This " + currentWordPeriod)
                .font(.system(size: 14))
                .foregroundColor(grayColor)
            Divider()
            Spacer()
            HStack(alignment: VerticalAlignment.bottom, spacing: 1){
                Text(String(format: formatLenght, currentValue))
                    .font(.system(size: 28) .bold())
                    .foregroundColor(.accentColor)
                Text(currentMetric)
                    .font(.system(size: 16))
                    .foregroundColor(.accentColor)
                    .padding(.bottom, 4)
                Spacer()
            }
            Text(String(12) + " " + acitivitiesLabel)
                .font(.system(size: 14))
                .foregroundColor(grayColor)
            Text(currentGoal > 0 ? String(goalPercent) + "% of the goal" : "No goal")
                .font(.system(size: 14))
                .foregroundColor(grayColor)
                .padding(.bottom, 4)
            
            ProgressView(value: progressPercent)
                .scaleEffect(x: 1.0, y: 3.0, anchor: .center)
                .tint(.accentColor)
                .padding(.bottom, 2)
        }
    }
}
