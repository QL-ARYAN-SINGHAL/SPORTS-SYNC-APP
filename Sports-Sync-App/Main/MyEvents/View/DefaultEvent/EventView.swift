//
//  EventView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 23/04/25.
//
import SwiftUI

struct EventView: View {
    @StateObject private var eventViewModal = EventInformationViewModal()

    var body: some View {
        VStack(spacing: 0) {
            if !eventViewModal.userCreatedEvents.isEmpty {
                ScrollView {
                    VStack(spacing: 16) {
                        
                        ForEach(eventViewModal.userCreatedEvents, id: \.self) { event in
                            UserCreatedEventView()
                        }
                        EventButton()
                    }
                }
            } else {
                Text("No events created yet.")
                    .foregroundColor(.gray)
                    .padding()
            }

            Spacer()
        }
        .padding()
        .task {
                 await eventViewModal.getUserCreatedEvent()
           
        }
        .environmentObject(eventViewModal)
    }
}

#Preview {
    EventView()
}
