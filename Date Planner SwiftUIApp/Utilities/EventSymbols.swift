//
//  EventSymbols.swift
//  Date Planner SwiftUIApp
//
//  Created by Navin Rai on 01/06/25.
//

import SwiftUI

struct EventSymbols {
    static let DUMMY_SYMBOLS = [ // Added DUMMY_ to avoid name clash if you have other 'symbols'
        "gift.fill", "theatermasks.fill", "facemask.fill", "leaf.fill",
        "gamecontroller.fill", "graduationcap.fill", "book.fill",
        "globe.americas.fill", "case.fill", "lightbulb.fill", "calendar",
        "pencil.and.outline", "trash.fill", "folder.fill", "paperplane.fill",
        "doc.text.fill", "bookmark.fill", "rosette", "star.fill"
    ]

    static func randomName() -> String {
        DUMMY_SYMBOLS.randomElement() ?? "calendar"
    }
}
