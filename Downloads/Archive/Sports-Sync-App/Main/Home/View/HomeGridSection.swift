import SwiftUI

struct HomeGridSection: View {
    @EnvironmentObject var cardViewModal: CardViewModel
    @EnvironmentObject var eventViewModal: EventInformationViewModal
    @State private var isNavigating = false

    let sectionTitles = ["Nearby", "Recommended", "Trending"]

    var body: some View {
        NavigationStack {
            List {
                ForEach(sectionTitles, id: \.self) { title in
                    Section {
                        Text(title)
                            .font(Font.custom(.fontJakartaBold, size: 20))
                            .frame(width: 300, height: 30, alignment: .leading)
                            .listRowSeparator(.hidden)
                            .padding(.top, 10)

                       
                        let cardsForSection = cardViewModal.cards(for: title)

                        if cardsForSection.isEmpty {
                            Text("No event found in \(title) section")
                                .font(Font.custom(.fontJakarta, size: 15))
                                .foregroundStyle(.black)
                                .padding(.leading, 16)
                        } else {
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 12) {
                                    ForEach(cardsForSection, id: \.self) {
                                        card in
                                        ReusableCards(cardData: card) {
                                            cardViewModal.selectCard(card)
                                            isNavigating = true
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .onAppear {
                        // Fetch cards only if they are not already loaded
                        if cardViewModal.cardsHomeData.isEmpty {
                            cardViewModal.fetchHomeCards()
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationDestination(isPresented: $isNavigating) {
                PlanDescriptionView()
                    .environmentObject(cardViewModal)
                    .environmentObject(eventViewModal)
            }
        }
    }
}

#Preview {
    HomeGridSection()
        .environmentObject(CardViewModel())
}
