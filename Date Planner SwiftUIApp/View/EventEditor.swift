//
//  EventEditor.swift
//  Date Planner SwiftUIApp
//
//  Created by Navin Rai on 01/06/25.
//


import SwiftUI

struct EventEditor: View {
    @Binding var event: Event
    var isNew: Bool = false // To differentiate behavior for Add/Save button

    @EnvironmentObject var eventData: EventData // To add if 'isNew'
    @Environment(\.dismiss) private var dismiss

    @State private var showingSymbolPicker = false

    var body: some View {
        Form {
            Section(header: Text("Event Info")) {
                HStack {
                    Button {
                        showingSymbolPicker = true
                    } label: {
                        Image(systemName: event.symbol)
                            .font(.title2)
                            .padding(8)
                            .background(Color.gray.opacity(0.1), in: Circle())
                            .foregroundColor(event.color)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    TextField("Event Title", text: $event.title)
                        .font(.title2.weight(.semibold))
                }
                
                DatePicker("Date and Time", selection: $event.date) // Can specify displayedComponents if needed
                
                Picker("Color", selection: $event.color) {
                    ForEach(ColorOptions.all, id: \.self) { color in
                        HStack {
                            Text(color.description.capitalized) // SwiftUI tries to make a description
                            Spacer()
                            Circle().fill(color).frame(width: 20, height: 20)
                        }
                        .tag(color) // Important: Tag with the actual color value
                    }
                }
                // .pickerStyle(.navigationLink) // Use if you want a separate view for color picking
            }

            Section(header: Text("Tasks")) {
                ForEach($event.tasks) { $taskBinding in // Use $ to get Binding<EventTask>
                    TaskRow(task: $taskBinding) // TaskRow needs a Binding
                }
                .onDelete { indices in
                    event.tasks.remove(atOffsets: indices)
                }

                Button {
                    let newTask = EventTask(text: "", isNew: true) // Mark as new for potential auto-focus
                    event.tasks.append(newTask)
                    // To ensure the new task gets focus, you might need to scroll to it
                    // or manage focus state more explicitly if TaskRow doesn't handle 'isNew' automatically.
                } label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Task")
                    }
                }
            }
        }
        .navigationTitle(isNew ? "New Event" : event.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                if isNew {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isNew ? "Add" : "Done") {
                    if isNew {
                        // Basic validation: ensure title is not empty before adding
                        if !event.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            eventData.add(event)
                        } else {
                            // Optionally, show an alert or prevent dismissal
                            // For now, we just don't add if title is empty.
                            // To prevent dismissal, you might return early or set a state.
                        }
                    }
                    // For editing, changes are already bound to the event object via @Binding.
                    // If you were editing a copy, you'd save it back to eventData here.
                    dismiss()
                }
                // Disable "Add" button if the title is empty for a new event
                .disabled(isNew && event.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
        .sheet(isPresented: $showingSymbolPicker) {
            // Present SymbolPicker in a NavigationView for its own title and potential toolbar
            NavigationView {
                SymbolPicker(selection: $event.symbol)
            }
        }
    }
}
