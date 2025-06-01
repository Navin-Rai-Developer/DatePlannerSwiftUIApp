//
//  SymbolPicker.swift
//  Date Planner SwiftUIApp
//
//  Created by Navin Rai on 01/06/25.
//

import SwiftUI

struct SymbolPicker: View {
    @Binding var selection: String
    @Environment(\.dismiss) private var dismiss // To close if presented as a sheet

    // Use the same symbols as EventSymbols for consistency
    private let symbols = EventSymbols.DUMMY_SYMBOLS
    @State private var searchText = ""

    var filteredSymbols: [String] {
        if searchText.isEmpty {
            return symbols
        } else {
            return symbols.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    // Define grid layout
    private let columns = [GridItem(.adaptive(minimum: 40))]

    var body: some View {
        // If this picker is meant to be a separate sheet/navigation:
        // NavigationView {
            VStack {
                TextField("Search Symbols", text: $searchText)
                    .padding()
                    .textFieldStyle(.roundedBorder)

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(filteredSymbols, id: \.self) { symbolName in
                            Button {
                                selection = symbolName
                                dismiss() // Dismiss if it's a sheet
                            } label: {
                                Image(systemName: symbolName)
                                    .font(.title2)
                                    .padding(8)
                                    .background(selection == symbolName ? Color.accentColor.opacity(0.3) : Color.clear, in: RoundedRectangle(cornerRadius: 8))
                                    .foregroundColor(selection == symbolName ? Color.accentColor : .primary)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Select Symbol")
            .navigationBarTitleDisplayMode(.inline)
            // .toolbar { // If used as a sheet with its own NavigationView
            //     ToolbarItem(placement: .navigationBarTrailing) {
            //         Button("Done") { dismiss() }
            //     }
            // }
        // }
    }
}
