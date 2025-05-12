//
//  EventView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 23/04/25.
//


import SwiftUI

import SwiftUI

struct EventView: View {
    @StateObject private var eventViewModel = EventInformationViewModal()
    @StateObject private var cardViewModel = CardViewModel()
    @StateObject private var firebaseValidation = FirebaseValidation()
    
    @State private var hasFetchedOnce = false  // <- Track initial fetch

    private var shouldShowUserCreatedEvents: Bool {
        eventViewModel.userCreatedEvents.contains { $0.id == firebaseValidation.currentUser?.id }
    }

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
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

                if shouldShowUserCreatedEvents && eventViewModel.isSubmitting && !hasFetchedOnce {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    ProgressView("Fetching Data...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 10)
                }
            }

            Spacer()
        }
        .padding()
        .task {
            if !hasFetchedOnce {
                await eventViewModel.getUserCreatedEvent()
                hasFetchedOnce = true
            }
        }
        .environmentObject(eventViewModel)
        .environmentObject(cardViewModel)
        .environmentObject(firebaseValidation)
    }
}

#Preview {
    EventView()
}
