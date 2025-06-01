//
//  Event.swift
//  Date Planner SwiftUIApp
//
//  Created by Navin Rai on 01/06/25.
//

import SwiftUI // For Color
import Foundation

struct Event: Identifiable, Hashable {
    var id = UUID()
    var symbol: String = EventSymbols.randomName() // Uses EventSymbols
    var color: Color = ColorOptions.random()    // Uses ColorOptions
    var title = ""
    var tasks = [EventTask(text: "")] // Assumes EventTask is defined
    var date = Date()

    var remainingTaskCount: Int {
        tasks.filter { !$0.isCompleted }.count
    }
    
    var isComplete: Bool {
        tasks.allSatisfy { $0.isCompleted }
    }
    
    var isPast: Bool {
        date < Date.now
    }
    
    var isWithinSevenDays: Bool {
        !isPast && date < Date.now.sevenDaysOut
    }
    
    var isWithinSevenToThirtyDays: Bool {
        !isPast && !isWithinSevenDays && date < Date.now.thirtyDaysOut
    }
    
    var isDistant: Bool {
        date >= Date.now.thirtyDaysOut // Corrected: was Date()
    }

    static var example = Event(
        symbol: "case.fill",
        title: "Sayulita Trip",
        tasks: [
            EventTask(text: "Buy plane tickets"),
            EventTask(text: "Get a new bathing suit"),
            EventTask(text: "Find an airbnb"),
        ],
        date: Date(timeIntervalSinceNow: 60 * 60 * 24 * 365 * 1.5)
    )
}

// Convenience methods for dates (can stay in Event.swift or move to a Date+Extensions.swift)
extension Date {
    var sevenDaysOut: Date {
        Calendar.autoupdatingCurrent.date(byAdding: .day, value: 7, to: self) ?? self
    }
    
    var thirtyDaysOut: Date {
        Calendar.autoupdatingCurrent.date(byAdding: .day, value: 30, to: self) ?? self
    }
}
