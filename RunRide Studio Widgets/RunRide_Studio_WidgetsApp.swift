//
//  RunRide_Studio_WidgetsApp.swift
//  RunRide Studio Widgets
//
//  Created by Stoyan Delev on 3.03.24.
//

import SwiftUI
import SwiftData

@main
struct RunRide_Studio_WidgetsApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
