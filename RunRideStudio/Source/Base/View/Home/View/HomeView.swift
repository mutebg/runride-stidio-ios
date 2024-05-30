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
        ZStack {
            Color(.brand1)
                .ignoresSafeArea()
            
            VStack {
                Text("Welcome")
                    .font(.system(size: 20))
                    .foregroundStyle(.textBrand1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("This app is part of www.RunRide.Studio platform, you can check your stats and infographics using same strava login")
                    .font(.system(size: 16))
                    .foregroundStyle(.textBrand1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                Button("View your stats") {
                    if let websiteUrl {
                        UIApplication.shared.open(websiteUrl)
                    }
                }.frame(
                    minWidth: 100, maxWidth: .infinity
                )
                .padding(8)
                .cornerRadius(5)
            }
        }
    }
}
