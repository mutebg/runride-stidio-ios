//
//  ContentView.swift
//  RunRide Studio Widgets
//
//  Created by Stoyan Delev on 3.03.24.
//

import SwiftUI

struct ContentView: View {
     
    @State private var useImperial = false
    @State private var stravaID: String?
    @State private var token: String?
    
    var isLogged: Bool {
        stravaID != nil && token != nil
    }
    
    var body: some View {
        ZStack {
            Image("splash")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack(spacing: 20 ) {
                    if isLogged {
                        SettingsView(stravaID: $stravaID, token: $token)
                    } else {
                        LoginView()
                    }
                }
                .padding(20)
                .background(Color(red: 0.043, green: 0.063, blue: 0.157))
                .cornerRadius(10)
                Spacer()
            }.padding(20)
        }
        .onOpenURL(perform: handleDeeplink)
        .onAppear {
            loadUserId()
        }
    }
        
    func loadUserId() {
        if let savedUserId = UserDefaultsConfig.stravaId {
            stravaID = savedUserId
        } else {
            // Handle the case where the value is not found (optional)
            print("strava_id not found in UserDefaults")
        }
         
        if let savedToken = UserDefaultsConfig.stravaToken {
            token = savedToken
        } else {
            // Handle the case where the value is not found (optional)
            print("strava_id not found in UserDefaults")
        }
    }
    
    func handleDeeplink(url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else { return }

        let _stravaID = queryItems.first(where: { $0.name == "id" })?.value
        let _token = queryItems.first(where: { $0.name == "token" })?.value

        if _stravaID != nil && _token != nil {
            UserDefaultsConfig.stravaId = _stravaID
            UserDefaultsConfig.stravaToken = _token
            stravaID = _stravaID
            token = _token
        }
    }
}

#Preview {
    ContentView()
}
