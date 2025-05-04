//
//  EventInformationViewModal.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 29/04/25.
////

import FirebaseFirestore
import SwiftUI

class EventInformationViewModal: ObservableObject {
    @Published var eventDataModal = EventDataModal()
    @Published var eventInfoData = EventInformationDataModal()
    @Published var didSubmitSuccessfully = false
    @Published var isSubmitting = false
    @Published var submittedEventInfo: EventInformationDataModal?
    @Published var userCreatedEvents: [EventInformationDataModal] = []

    let db = Firestore.firestore()

    // This function can be used to add an event to Firestore
    func eventInformationStoreDB(
        eventName: String, sportsName: String, eventDate: String,
        eventTime: String, state: String, selectedStadium: String
    ) {
        let eventData = EventInformationDataModal(
            searchText: "",
            eventName: eventName,
            eventDate: eventDate,
            sportsName: sportsName,
            eventTime: eventTime,
            selectedStadium: selectedStadium,
            stadium: "",
            showStadiumDetail: true
        )

        let dataDict: [String: Any] = [
            "EventName": eventName,
            "SportsName": sportsName,
            "EventDate": eventDate,
            "EventTime": eventTime,
            "State": state,
            "SelectedStadium": selectedStadium,
        ]

        db.collection("User Event").addDocument(data: dataDict) { error in
            DispatchQueue.main.async {
                if error == nil {
                    self.submittedEventInfo = eventData
                    self.didSubmitSuccessfully = true
                } else {
                    print("Error saving event: \(error!.localizedDescription)")
                    self.didSubmitSuccessfully = false
                }
            }
        }
    }

    // This function fetches events asynchronously using await/async
    func getUserCreatedEvent() async {
        do {
            let snapshot = try await db.collection("User Event").getDocuments()

            var events: [EventInformationDataModal] = []

            for document in snapshot.documents {
                let data = document.data()

                let eventName =
                    data["Event Name"] as? String ?? data["EventName"]
                    as? String ?? ""
                let sportsName =
                    data["Sports Name"] as? String ?? data["SportsName"]
                    as? String ?? ""
                let eventDate =
                    data["Event Date"] as? String ?? data["EventDate"]
                    as? String ?? ""
                let eventTime =
                    data["Event Time"] as? String ?? data["EventTime"]
                    as? String ?? ""
                let selectedStadium =
                    data["Selected Stadium"] as? String ?? data[
                        "SelectedStadium"] as? String ?? ""
                let state = data["State"] as? String ?? ""

                let event = EventInformationDataModal(
                    searchText: state,
                    eventName: eventName,
                    eventDate: eventDate,
                    sportsName: sportsName,
                    eventTime: eventTime,
                    selectedStadium: selectedStadium,
                    stadium: "",
                    showStadiumDetail: true
                )

                events.append(event)
            }

            // Update the state on the main thread
            DispatchQueue.main.async {
                self.userCreatedEvents = events
                print(self.userCreatedEvents)
            }
        } catch {
            print(
                "Error fetching userEvent collection: \(error.localizedDescription)"
            )
            return
        }
    }

    func resetFields() {
        eventInfoData = EventInformationDataModal()
    }

    func checkValidation() -> Bool {
        return !eventInfoData.eventName.isEmpty
            && !eventInfoData.sportsName.isEmpty
            && !eventInfoData.eventDate.isEmpty
            && !eventInfoData.eventTime.isEmpty
            && eventInfoData.selectedStadium != nil
    }
}
