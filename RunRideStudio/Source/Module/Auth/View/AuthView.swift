//
//  AuthView.swift
//  RunRideStudio
//
//  Created by Arman Turalin on 30.05.2024.
//

import SwiftUI

struct AuthView: View {
    @State var toLogin = false

    var body: some View {
        NavigationView {
            ZStack {
                Color(uiColor: .secondarySystemGroupedBackground)
                    .ignoresSafeArea()

                VStack {
                    VStack {
                        Spacer()
                    }
                    .overlay {
                        ZStack {
                            Image(.welcomeCover)

                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color(uiColor: .secondarySystemGroupedBackground).opacity(0), location: 0.65),
                                    Gradient.Stop(color: Color(uiColor: .secondarySystemGroupedBackground), location: 1.0),
                                ],
                                startPoint: UnitPoint(x: 0.5, y: 0),
                                endPoint: UnitPoint(x: 0.5, y: 1)
                            )
                        }
                    }
                    VStack(spacing: 32) {
                        Text("Welcome to RunRideStudio")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.textBrand1)
                            .multilineTextAlignment(.center)
                        VStack(spacing: 16) {
                            Button {
                                toLogin.toggle()
                            } label: {
                                HStack {
                                    Text("Login with Strava")
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                }
                                .padding(.vertical, 20)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .background(.orange)
                                .cornerRadius(16)
                            }

                            Text("You need to Login into Strava before start adding widgets")
                                .font(.footnote)
                                .foregroundColor(.textBrand1)
                                .multilineTextAlignment(.center)
                                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                                .opacity(0.6)
                        }
                    }
                    .padding([.horizontal, .bottom], 24)
                    .padding(.top, 42)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                    .background(Color(uiColor: .secondarySystemGroupedBackground))
                    .sheet(isPresented: $toLogin) {
                        StravaAuthView()
                    }
                }
            }
        }
    }
}

#Preview {
    AuthView()
}
