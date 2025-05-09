import SwiftUI

struct HomeSearchAndList: View {

    @EnvironmentObject var cardViewModal: CardViewModel

    let sportsNames = [
        "Cricket", "Badminton", "Football", "Tennis", "Volleyball",
        "HorseRiding", "Golf", "FormulaF1Racing",
    ]

    @State private var selectedSport: String? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            // Textfield to filter cards as per the sports when submitted
            TextField(
                "Search Tournaments",
                text: $cardViewModal.homeDataModal.searchText
            )
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal, 16)
            .onSubmit {
                selectedSport = cardViewModal.homeDataModal.searchText
                cardViewModal.filterCards(by: selectedSport)
            }

            // Horizontal list of sport buttons that filters sports cards
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    Button(action: {
                        selectedSport = nil
                        cardViewModal.filterCards(by: nil)
                    }) {
                        Text("All")
                            .font(.custom(.fontJakarta, size: 14))
                            .foregroundColor(.white)
                            .frame(width: 100, height: 40)
                            .background(Color.appTint)
                            .cornerRadius(10)
                    }

                    ForEach(sportsNames, id: \.self) { sport in
                        ReusableListButtons(buttonText: sport) {
                            selectedSport = sport
                            cardViewModal.filterCards(by: sport)
                        }
                        .frame(width: 100, height: 40)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .padding(.top, 12)
    }
}

#Preview {
    HomeSearchAndList()
        .environmentObject(CardViewModel())
}
