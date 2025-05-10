import SwiftUI

struct UserCreatedEventView: View {

    //EnvironemntObject
    @EnvironmentObject var eventViewModal: EventInformationViewModal
    @EnvironmentObject var cardViewModal: CardViewModel

    //States
    @State private var shouldNavigate: Bool = false
    @State private var selectedUserEvent: EventInformationDataModal? = nil
    @State private var selectedStadiumData: HomeCardsDataModal? = nil

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 16) {

                    ForEach(eventViewModal.filteredEventsWeek, id: \.self) {
                        event in

                        let matchingStadium = cardViewModal.cardsHomeData.first
                        {
                            $0.stadiumName == event.selectedStadium
                        }

                        ReusableUserCreatedEvent(
                            eventInfoDataModal: event,
                            stadiumData: matchingStadium,
                            action: {
                                selectedUserEvent = event
                                selectedStadiumData = matchingStadium
                                shouldNavigate = true
                            }
                        )

                    }
                }
                .padding()
            }
        }
        .onAppear {
            cardViewModal.fetchHomeCards()
            Task {
                await eventViewModal.getUserCreatedEvent()
            }
        }
        .navigationDestination(isPresented: $shouldNavigate) {
            if let userEvent = selectedUserEvent {
                PlanDescriptionView(
                    userEvent: userEvent, stadiumData: selectedStadiumData
                )
                .environmentObject(cardViewModal)
                .environmentObject(eventViewModal)
            }
        }

    }
}

#Preview {
    UserCreatedEventView()
        .environmentObject(EventInformationViewModal())
        .environmentObject(CardViewModel())
        .environmentObject(FirebaseValidation())
}
