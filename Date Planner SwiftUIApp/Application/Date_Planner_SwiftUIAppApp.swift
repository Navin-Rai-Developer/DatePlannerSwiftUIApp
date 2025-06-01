//
//  Date_Planner_SwiftUIAppApp.swift
//  Date Planner SwiftUIApp
//
//  Created by Navin Rai on 01/06/25.
//


import SwiftUI

@main
struct Date_Planner_SwiftUIAppApp: App {
    // Your existing @StateObject for EventData
    @StateObject private var eventData = EventData() // Assuming this is how you manage data

    // New state variable to control launch screen visibility
    @State private var isLaunchFinished = false

    var body: some Scene {
        WindowGroup {
            // Use a Group to switch between LaunchView and your main content
            Group {
                if isLaunchFinished {
                    // This is your existing main view structure
                    NavigationView {
                        EventList() // Your main list view
                        Text("Select an Event") // For iPad detail view placeholder
                            .foregroundStyle(.secondary)
                    }
                    .environmentObject(eventData) // Pass your existing eventData
                } else {
                    // Show the LaunchView and pass the binding
                    LaunchView(isFinished: $isLaunchFinished)
                }
            }
        }
    }
}
