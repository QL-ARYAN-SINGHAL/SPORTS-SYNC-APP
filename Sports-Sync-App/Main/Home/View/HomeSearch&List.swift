import SwiftUI

struct HomeTopSearchAndList: View {
    
    @EnvironmentObject var cardViewModal: CardViewModel
    
    let sportsNames = ["Cricket", "Badminton", "Football", "Tennis", "Volleyball", "Hockey", "Basketball", "Swimming"]
    
    @State private var selectedSport: String? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
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
        .frame(height: 50)
        .searchable(text: $cardViewModal.homeDataModal.searchText, prompt: "Search Tournaments")
    }
}


#Preview {
    HomeTopSearchAndList()
        .environmentObject(CardViewModel())
}
