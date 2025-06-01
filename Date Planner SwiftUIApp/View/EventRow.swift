//
//  EventRow.swift
//  Date Planner SwiftUIApp
//
//  Created by Navin Rai on 01/06/25.
//


import SwiftUI

struct EventRow: View {
    let event: Event // EventRow displays event data, doesn't need to bind by default

    var body: some View {
        HStack {
            Image(systemName: event.symbol)
                .font(.title3)
                .foregroundColor(event.color)
                .padding(.trailing, 5)

            VStack(alignment: .leading) {
                Text(event.title)
                    .font(.headline)
                Text(event.date, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            if event.isComplete {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            } else if event.remainingTaskCount > 0 {
                Text("\(event.remainingTaskCount)")
                    .font(.caption.bold())
                    .foregroundColor(.white)
                    .padding(6)
                    .background(event.color.opacity(0.8), in: Circle())
            }
        }
        .padding(.vertical, 4)
    }
}
