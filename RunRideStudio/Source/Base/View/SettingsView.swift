//
//  SettingsView.swift
//  RunRideStudio
//
//  Created by Stoyan Delev on 3.03.24.
//

import SwiftUI

struct SettingsView: View {
    @Binding var stravaID: String?
    @Binding var token: String?
    @State private var useImperial = false
    
    var body: some View {
        Text("Welcome")
        .font(.system(size: 20))
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
            
            
        
        Text("This app is part of www.RunRide.Studio platform, you can check your stats and infographics using same strava login")
            .font(.system(size: 16))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            
        Button("View your stats") {
            if let url = URL(string: "https://runride.studio/ok?token=" + ( token ?? "" ) + "&id=" + (stravaID ?? "")) {
                UIApplication.shared.open(url)
            }
            
        }.frame(
            minWidth: 100, maxWidth: .infinity
        )
        .padding(8)
        .background(
            Color(red: 0.404, green: 0.314, blue: 0.643)
        )
        .foregroundColor(.white)
        .cornerRadius(5)
        
        Divider()
        
        
        Text("Settings")
        .frame(maxWidth: .infinity, alignment: .leading)
            .font(.system(size: 20))
            .foregroundColor(.white)
        Toggle("Use Imperial system", isOn: $useImperial)
            .onChange(of: useImperial) {
                UserDefaults(suiteName: "group.runride_studio")!.set(useImperial, forKey: "useImperial")
            }
            .foregroundColor(.white)

        Button("Logout") {
            UserDefaults(suiteName: "group.runride_studio")!.removeObject(forKey: "token")
            UserDefaults(suiteName: "group.runride_studio")!.removeObject(forKey: "strava_id")
            token = nil
            stravaID = nil
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
      
        
        Divider().onAppear {
            loadSettings()
        }
        
        Text("Powered by Strava")
        .frame(maxWidth: .infinity, alignment: .leading)
            .font(.system(size: 14))
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
    }
    
    
    func loadSettings () {
        let savedUseImperial = UserDefaults(suiteName: "group.runride_studio")!.bool(forKey: "useImperial")
        useImperial = savedUseImperial
   }
}
