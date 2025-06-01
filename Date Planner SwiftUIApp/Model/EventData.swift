//
//  EventData.swift
//  Date Planner SwiftUIApp
//
//  Created by Navin Rai on 01/06/25.
//

import SwiftUI // For Binding and Color
import Combine // For ObservableObject

class EventData: ObservableObject {
    @Published var events: [Event] = [
        Event(symbol: "gift.fill",
              color: .red,
              title: "Maya's Birthday",
              tasks: [EventTask(text: "Guava kombucha"),
                      EventTask(text: "Paper cups and plates"),
                      EventTask(text: "Cheese plate"),
                      EventTask(text: "Party poppers"),
                     ],
              date: Date.roundedHoursFromNow(60 * 60 * 24 * 30)),
        Event(symbol: "theatermasks.fill",
              color: .yellow,
              title: "Pagliacci",
              tasks: [EventTask(text: "Buy new tux"),
                      EventTask(text: "Get tickets"),
                      EventTask(text: "Pick up Carmen at the airport and bring her to the show"),
                     ],
              date: Date.roundedHoursFromNow(60 * 60 * 22)),
        // ... (rest of your sample events)
        Event(symbol: "case.fill",
              color: .orange,
              title: "Sayulita Trip",
              tasks: [
                  EventTask(text: "Buy plane tickets"),
                  EventTask(text: "Get a new bathing suit"),
                  EventTask(text: "Find a hotel room"),
              ],
              date: Date.roundedHoursFromNow(60 * 60 * 24 * 19)),
    ]

    func delete(_ event: Event) {
        events.removeAll { $0.id == event.id }
    }
    
    func add(_ event: Event) {
        events.append(event)
        // Optionally sort events after adding
        // events.sort { $0.date < $1.date }
    }
    
    func exists(_ event: Event) -> Bool {
        events.contains(event) // Relies on Event being Hashable
    }
    
    func sortedEvents(period: Period) -> Binding<[Event]> {
        Binding<[Event]>(
            get: {
                self.events
                    .filter { event in // Added 'event in' for clarity
                        switch period {
                        case .nextSevenDays:
                            return event.isWithinSevenDays
                        case .nextThirtyDays:
                            return event.isWithinSevenToThirtyDays
                        case .future:
                            return event.isDistant
                        case .past:
                            return event.isPast
                        }
                    }
                    .sorted { $0.date < $1.date }
            },
            set: { updatedEventsFromBinding in // Renamed for clarity
                for event in updatedEventsFromBinding {
                    if let index = self.events.firstIndex(where: { $0.id == event.id }) {
                        self.events[index] = event
                    }
                }
            }
        )
    }
}

enum Period: String, CaseIterable, Identifiable {
    case nextSevenDays = "Next 7 Days"
    case nextThirtyDays = "Next 30 Days"
    case future = "Future" // Events further than 30 days
    case past = "Past"
    
    var id: String { self.rawValue }
    var name: String { self.rawValue }
}

// Date extensions (can be in a separate Date+Extensions.swift file)
extension Date {
    static func from(month: Int, day: Int, year: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(from: dateComponents) ?? Date()
    }

    static func roundedHoursFromNow(_ hoursAhead: Double) -> Date {
        let exactDate = Date(timeIntervalSinceNow: hoursAhead) // Parameter is time interval
        guard let hourRange = Calendar.current.dateInterval(of: .hour, for: exactDate) else {
            return exactDate
        }
        return hourRange.end
    }
}
