//
//  ColorOptions.swift
//  Date Planner SwiftUIApp
//
//  Created by Navin Rai on 01/06/25.
//

import SwiftUI

struct ColorOptions {
    static let all: [Color] = [
        .red, .orange, .yellow, .green, .mint, .teal, .cyan, .blue, .indigo,
        .purple, .pink, .brown, .gray // Removed .primary and .black for simplicity in picker
    ]

    static func random() -> Color {
        all.randomElement() ?? .blue
    }
}
