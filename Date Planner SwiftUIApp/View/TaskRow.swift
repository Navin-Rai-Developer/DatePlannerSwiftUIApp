//
//  TaskRow.swift
//  Date Planner SwiftUIApp
//
//  Created by Navin Rai on 01/06/25.
//

import SwiftUI

struct TaskRow: View {
    @Binding var task: EventTask
    @FocusState var isFocused: Bool // To handle focus for new tasks

    var body: some View {
        HStack {
            Button {
                task.isCompleted.toggle()
            } label: {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2) // Slightly larger tap area
                    .foregroundColor(task.isCompleted ? .green : .gray)
            }
            .buttonStyle(PlainButtonStyle()) // Use PlainButtonStyle in lists for better behavior

            TextField("Task Description", text: $task.text, axis: .vertical)
                .focused($isFocused)
                .onChange(of: task.isNew) { // was isNew in your EventTask
                    if task.isNew {
                        isFocused = true // Focus when a new task is marked as new
                        // task.isNew = false // Reset after focusing, or manage this in EventEditor
                    }
                }
            Spacer() // Pushes TextField to take available space before any potential delete button
        }
    }
}
