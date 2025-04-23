//
//  EventListView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 23/04/25.
//

import SwiftUI

struct EventListView: View {
    @State private var birthDate = Date.now

        var body: some View {
            VStack {
                DatePicker(selection: $birthDate, in: ...Date.now, displayedComponents: .date) {
                    Text("Select a date")
                }

                Text("Date is \(birthDate.formatted(date: .long, time: .omitted))")
            }
        }
}

#Preview {
    EventListView()
}
