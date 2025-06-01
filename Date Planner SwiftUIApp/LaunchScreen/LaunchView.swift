//
//  LaunchView.swift
//  Date Planner SwiftUIApp
//
//  Created by Navin Rai on 01/06/25.
//

import SwiftUI

struct LaunchView: View {
    @Binding var isFinished: Bool // This will be controlled by the App struct
    let launchImageName = "Image Background Blue Minimal Phone Wallpaper" // Your asset name

    var body: some View {
        ZStack {
            Image(launchImageName)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .overlay(Color.black.opacity(0.1)) // Optional: slight dimming

            VStack {
                Spacer()
                Text("Life Is A Journey")
                    // Attempt to use a script-like system font if SnellRoundhand isn't available
                    .font(.custom("SnellRoundhand-Bold", size: 42) ?? .system(size: 40, weight: .bold, design: .serif))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.6), radius: 2, x: 1, y: 1)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)

                Text("Date and Plan")
                    .font(.custom("SnellRoundhand", size: 30) ?? .system(size: 28, design: .serif))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.6), radius: 2, x: 1, y: 1)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                Spacer()
                Spacer()
            }
        }
        .onAppear {
            // Simulate some loading or just show for a fixed time
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // Show for 3 seconds
                withAnimation(.easeInOut(duration: 0.7)) {
                    self.isFinished = true // Tell the App struct to switch views
                }
            }
        }
    }
}
