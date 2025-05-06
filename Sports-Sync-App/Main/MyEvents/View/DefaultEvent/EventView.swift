//
//  EventView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 23/04/25.
//


import SwiftUI

struct EventView: View {
    @StateObject private var eventViewModel = EventInformationViewModal()
    @StateObject private var cardViewModel = CardViewModel()
    @StateObject private var firebaseValidation = FirebaseValidation()

    private var shouldShowUserCreatedEvents: Bool {
        eventViewModel.userCreatedEvents.contains { $0.id == firebaseValidation.currentUser?.id }
    }

    var body: some View {
        VStack(spacing: 0) {
            if shouldShowUserCreatedEvents {
                ScrollView {
                    VStack(spacing: 16) {
                        EventListView()
                        UserCreatedEventView()
                        EventButton()
                    }
                }
            } else {
                VStack(spacing: 16) {
                    EventListView()
                    Spacer().frame(height: 100)
                    EventTextView()
                    EventButton()
                }
            }

            Spacer()
        }
        .padding()
        .task {
            await eventViewModel.getUserCreatedEvent()
        
            print("Event IDs:", eventViewModel.userCreatedEvents.map { $0.id })
            print("Current User ID:", firebaseValidation.currentUser?.id ?? "nil")
        }
        .environmentObject(eventViewModel)
        .environmentObject(cardViewModel)
    }
}

#Preview {
    EventView()
}
