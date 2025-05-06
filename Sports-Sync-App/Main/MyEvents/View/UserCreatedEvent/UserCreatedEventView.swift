import SwiftUI

struct UserCreatedEventView: View {

    @EnvironmentObject var eventViewModal: EventInformationViewModal
    @EnvironmentObject var cardViewModal: CardViewModel

    @State private var shouldNavigate: Bool = false

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 16) {

                   
                    ForEach(eventViewModal.userCreatedEvents, id: \.self) { event in

                        let matchingStadium = cardViewModal.cardsHomeData.first {
                            $0.stadiumName == event.selectedStadium
                        }

                        ReusableUserCreatedEvent(
                            eventInfoDataModal: event,
                            stadiumData: matchingStadium,
                            action: {
                                shouldNavigate = true
                            }
                        )
                    }
                }
                .padding()
            }
        }
        .onAppear {
            cardViewModal.fetchAllCards()
            Task {
                await eventViewModal.getUserCreatedEvent()
            }
        }
        .navigationDestination(isPresented: $shouldNavigate) {
            PlanDescriptionView(cardViewModel: CardViewModel())
        }
    }
}


#Preview {
    UserCreatedEventView()
        .environmentObject(EventInformationViewModal())
        .environmentObject(CardViewModel())
        .environmentObject(FirebaseValidation())
}
