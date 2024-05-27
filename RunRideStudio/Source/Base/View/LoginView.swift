//
//  LoginView.swift
//  RunRideStudio
//
//  Created by Stoyan Delev on 3.03.24.
//

import SwiftUI

struct LoginView: View {
    @State private var isAuthenticating = false
    
    var body: some View {
        Image("logo") // Use the name of your image file
            .resizable()
            .scaledToFit() // Adjust image size
            .frame(width: 120, height: 120)
            .cornerRadius(10)
        
        Text("Welcome to RunRide Studio")
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.system(size: 20))
            .foregroundColor(.white)
            
        
        Text("You need to Login into Strava before start adding widgets").font(.system(size: 16))
            .foregroundColor(.white)
            .multilineTextAlignment(.leading)
        
        
        Button("Login with Strava") {
            isAuthenticating = true // Start authentication process
        }
        .frame(
            minWidth: 100, maxWidth: .infinity
        )
        .padding(8)
        .background(
            Color(red: 0.404, green: 0.314, blue: 0.643)
        )
        .foregroundColor(.white)
        .cornerRadius(5)
        .frame(maxWidth: .infinity)
        .sheet(isPresented: $isAuthenticating) {
            StravaAuthView()
        }
    }
}
