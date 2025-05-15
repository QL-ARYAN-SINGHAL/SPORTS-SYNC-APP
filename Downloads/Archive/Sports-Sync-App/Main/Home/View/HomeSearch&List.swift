import SwiftUI

struct HomeSearchAndList: View {
    
    @EnvironmentObject var cardViewModal: CardViewModel

    let sportsNames = [
        "Cricket", "Badminton", "Football", "Tennis", "VolleyBall",
        "HorseRiding", "Golf", "FormulaF1Racing",
    ]
    
    @State private var selectedSport: String? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            // MARK: - Search TextField
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
            
            // MARK: - Horizontal Scrollable Buttons
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    
                    // ALL BUTTON
                    Button(action: {
                        selectedSport = nil
                        cardViewModal.filterCards(by: nil)
                    }) {
                        Text("All")
                            .font(.custom(.fontJakarta, size: 14))
                            .foregroundColor(selectedSport == nil ? .white : .appTint)
                            .frame(width: 100, height: 40)
                            .background(selectedSport == nil ? Color.appTint : Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.appTint, lineWidth: selectedSport == nil ? 0 : 1)
                            )
                            .cornerRadius(10)
                    }

                    // SPORT BUTTONS
                    ForEach(sportsNames, id: \.self) { sport in
                        ReusableListButtons(
                            buttonText: sport,
                            isSelected: selectedSport == sport
                        ) {
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
