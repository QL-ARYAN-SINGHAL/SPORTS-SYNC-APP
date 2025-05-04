import SwiftUI

struct UserCreatedEventView: View {

    @EnvironmentObject var eventViewModal: EventInformationViewModal
    @EnvironmentObject var cardViewModal: CardViewModel

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(eventViewModal.userCreatedEvents, id: \.self) {
                        event in

                        let matchingStadium = cardViewModal.cardsHomeData.first
                        {
                            $0.stadiumName == event.selectedStadium
                        }

                        ReusableUserCreatedEvent(
                            eventInfoDataModal: event,
                            stadiumData: matchingStadium
                        )
                    }
                }
                .padding()
            }
        }
        .onAppear {
            cardViewModal.fetchAllCards()
        }
    }
}

#Preview {
    UserCreatedEventView()
        .environmentObject(EventInformationViewModal())
        .environmentObject(CardViewModel())
}
