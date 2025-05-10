    //
    //  EventInformationViewModal.swift
    //  Sports-Sync-App
    //
    //  Created by ARYAN SINGHAL on 29/04/25.

    import SwiftUI
    import FirebaseFirestore
    import FirebaseAuth

    @MainActor
    class EventInformationViewModal: ObservableObject {
        
        // MARK: - Published Properties
        @Published var eventDataModal = EventDataModal()
        @Published var eventInfoData = EventInformationDataModal()
        
        @Published var submittedEventInfo: EventInformationDataModal?
        
        //MARK: - ARRAY VARIABLES THAT STORES THE DTA TO BE REPRRESENTED IN VIEW
        //SHOWS USER CREATEDEVENTS
        @Published var userCreatedEvents: [EventInformationDataModal] = []
        
        //SHOW FILTEREDEVENTS AS PER THE WEEK
        @Published var filteredEventsWeek: [EventInformationDataModal] = []
        
        
        //STATES
        @Published var didSubmitSuccessfully = false
        @Published var isSubmitting = false

        // MARK: - Dependencies
        private let db = Firestore.firestore()
        
        // TODO: Use dependency injection for FirebaseValidation instead of @StateObject in future for better testability and architecture
        @StateObject var firebaseValidation = FirebaseValidation()

        // MARK: - Firestore: Store Event
        func eventInformationStoreDB(
            id: String,
            eventName: String,
            sportsName: String,
            eventDate: String,
            eventTime: String,
            state: String,
            selectedStadium: String
        ) {
            let eventData = EventInformationDataModal(
                searchText: state,
                eventName: eventName,
                eventDate: eventDate,
                sportsName: sportsName,
                eventTime: eventTime,
                selectedStadium: selectedStadium,
                stadium: "",
                showStadiumDetail: true,
                id: id
            )

            let dataDict: [String: Any] = [
                "EventName": eventName,
                "SportsName": sportsName,
                "EventDate": eventDate,
                "EventTime": eventTime,
                "State": state,
                "SelectedStadium": selectedStadium,
                "id": id
            ]

            db.collection("User Event").addDocument(data: dataDict) { error in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Error saving event: \(error.localizedDescription)")
                        self.didSubmitSuccessfully = false
                    } else {
                        self.submittedEventInfo = eventData
                        self.didSubmitSuccessfully = true
                    }
                }
            }
        }
        
        //  MARK: - FILTERERD USER CREATED EVENTS AS PER THE WEEKS
        

        // Helper to convert "dd-MM-yyyy" string to Date
        private func convertToDate(_ dateString: String) -> Date? {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            return formatter.date(from: dateString)
        }

        // Week filtering method
        func filterEvents(for weekStartDate: Date) {
            let calendar = Calendar.current
            let weekEndDate = calendar.date(byAdding: .day, value: 6, to: weekStartDate)!

            filteredEventsWeek = userCreatedEvents.filter { event in
                guard let date = convertToDate(event.eventDate) else { return false }
                return date >= weekStartDate && date <= weekEndDate
            }
        }


        // MARK: - Firestore: Fetch User-Created Events
        func getUserCreatedEvent() async {
            guard let currentUserID = firebaseValidation.userSession?.uid else {
                print("User not logged in")
                return
            }

            do {
                let snapshot = try await db.collection("User Event")
                    .whereField("id", isEqualTo: currentUserID)
                    .getDocuments()

                var events: [EventInformationDataModal] = []

                for document in snapshot.documents {
                    let data = document.data()

                    let event = EventInformationDataModal(
                        searchText: data["State"] as? String ?? "",
                        eventName: data["Event Name"] as? String ?? data["EventName"] as? String ?? "",
                        eventDate: data["Event Date"] as? String ?? data["EventDate"] as? String ?? "",
                        sportsName: data["Sports Name"] as? String ?? data["SportsName"] as? String ?? "",
                        eventTime: data["Event Time"] as? String ?? data["EventTime"] as? String ?? "",
                        selectedStadium: data["Selected Stadium"] as? String ?? data["SelectedStadium"] as? String ?? "",
                        stadium: "",
                        showStadiumDetail: true,
                        id: data["id"] as? String ?? ""
                    )

                    events.append(event)
                }

                DispatchQueue.main.async {
                    self.userCreatedEvents = events
                    // Default filter: current week
                    let startOfWeek = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
                    self.filterEvents(for: startOfWeek)
                }


            } catch {
                print("Error fetching user events: \(error.localizedDescription)")
            }
        }

        // MARK: - Form Reset
        func resetFields() {
            eventInfoData = EventInformationDataModal()
        }

        // MARK: - Form Validation
        func checkValidation() -> Bool {
            return !eventInfoData.eventName.isEmpty &&
                   !eventInfoData.sportsName.isEmpty &&
                   !eventInfoData.eventDate.isEmpty &&
                   !eventInfoData.eventTime.isEmpty &&
                   eventInfoData.selectedStadium != nil
        }
    }
