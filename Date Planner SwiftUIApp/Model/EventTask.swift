//
//  EventTask.swift
//  Date Planner SwiftUIApp
//
//  Created by Navin Rai on 01/06/25.
//

import Foundation

struct EventTask: Identifiable, Hashable {
    var id = UUID()
    var text: String
    var isCompleted = false
    var isNew = false // You might use this for UI logic when adding new tasks
}
