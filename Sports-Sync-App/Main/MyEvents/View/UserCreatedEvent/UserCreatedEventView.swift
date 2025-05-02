//
//  UserCreatedEventView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 01/05/25.
//

import SwiftUI

struct UserCreatedEventView: View {
    
    @EnvironmentObject var eventViewModal: EventInformationViewModal
    
    var body: some View {
        VStack {
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(eventViewModal.userCreatedEvents, id: \.self) { event in
                           
                            let stadiumData = HomeCardsDataModal(
                                imageName: "https://example.com/image.png",  // Replace with actual data
                                sportsName: event.sportsName,
                                location: "Location", // Replace with actual location data if available
                                rating: "4.5", // Replace with actual rating if available
                                description: "Sample Description", // Replace with actual description if needed
                                stadiumName: event.selectedStadium ?? "",
                                eventDate: event.eventDate,
                                eventTime: event.eventTime
                            )
                            
                            ReusableUserCreatedEvent(stadiumcardData: stadiumData, eventInfoDataModal: event)
                        }
                    }
                }
           
        }
    }
}

#Preview {
    UserCreatedEventView()
}
