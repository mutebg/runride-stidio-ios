//
//  ContentView.swift
//  RunRide Studio Widgets
//
//  Created by Stoyan Delev on 3.03.24.
//

import SwiftUI
import SwiftData
import SafariServices

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
                        ViewSettings(stravaID: $stravaID, token: $token)
                    } else {
                        ViewLogin()
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
        if let savedUserId = UserDefaults(suiteName: "group.runride_studio")!.string(forKey: "strava_id") {
            stravaID = savedUserId
        } else {
            // Handle the case where the value is not found (optional)
            print("strava_id not found in UserDefaults")
        }
         
         if let savedToken = UserDefaults(suiteName: "group.runride_studio")!.string(forKey: "token") {
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
            
            UserDefaults(suiteName: "group.runride_studio")!.set(_stravaID, forKey: "strava_id")
            UserDefaults(suiteName: "group.runride_studio")!.set(_token, forKey: "token")
            stravaID = _stravaID
            token = _token
        }
    }
    
   
}

struct ViewLogin: View {
    
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

struct StravaAuthView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let authURL = URL(string: "https://api-izq36taffa-uc.a.run.app/login?platform=ios");
        return SFSafariViewController(url: authURL!)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        // Not needed for basic setup
    }
}

struct ViewSettings: View {
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

#Preview {
    ContentView()
}

