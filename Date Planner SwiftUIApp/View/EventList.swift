//
//  ContentView.swift
//  Date Planner SwiftUIApp
//
//  Created by Navin Rai on 01/06/25.
//

import SwiftUI

struct EventList: View {
    @EnvironmentObject var eventData: EventData
    @State private var isAddingNewEvent = false
    @State private var newEventDraft = Event() // Draft for a new event

    var body: some View {
        List {
            ForEach(Period.allCases) { period in
                // Get the binding to the array of events for this specific period
                let eventsForPeriodBinding = eventData.sortedEvents(period: period)
                
                // Only show the section if there are events for this period
                if !eventsForPeriodBinding.wrappedValue.isEmpty {
                    Section {
                        // Iterate over the binding to get bindings to individual events
                        // $eventInPeriod is a Binding<Event>
                        ForEach(eventsForPeriodBinding) { $eventInPeriod_Bindable in
                            NavigationLink {
                                // Pass the Binding<Event> directly to EventEditor
                                EventEditor(event: $eventInPeriod_Bindable)
                            } label: {
                                // EventRow takes a non-binding Event (the wrapped value)
                                EventRow(event: eventInPeriod_Bindable)
                            }
                            .swipeActions(edge: .trailing) { // Specify edge for clarity
                                Button(role: .destructive) {
                                    // eventInPeriod_Bindable is an Event here (the wrapped value from the binding)
                                    // This is fine for delete, as delete uses the ID.
                                    eventData.delete(eventInPeriod_Bindable)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            // You could add a leading swipe action for "Toggle Complete" if desired
                        }
                    } header: { // Using the modern Section(content:header:) syntax
                        Text(period.name)
                            .font(.callout)
                            .foregroundColor(.secondary)
                            .fontWeight(.bold)
                    }
                }
            }
        }
        .navigationTitle("Date Planner")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) { // Explicit placement
                Button {
                    newEventDraft = Event() // Reset the draft for a fresh new event
                    isAddingNewEvent = true
                } label: {
                    Image(systemName: "plus.circle.fill") // More descriptive icon
                        .font(.title2) // Slightly larger
                }
            }
        }
        .sheet(isPresented: $isAddingNewEvent) {
            NavigationView { // Add NavigationView for toolbar and title in the sheet
                EventEditor(event: $newEventDraft, isNew: true)
                // .environmentObject(eventData) // Not strictly needed if parent view has it, sheets inherit
            }
        }
    }
}

#Preview { // Your preview was fine
    NavigationView {
        EventList()
            .environmentObject(EventData()) // EventData for preview
    }
}
