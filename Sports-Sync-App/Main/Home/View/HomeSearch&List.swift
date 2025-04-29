import SwiftUI

struct HomeTopSearchAndList: View {
    
    @EnvironmentObject var homeViewModal: HomeViewModal
    
    let sportsNames = ["Cricket", "Badminton", "Football", "Tennis", "Volleyball", "Hockey", "Basketball", "Swimming"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    Button(action: {
                        homeViewModal.homeDataModal.searchText = ""
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
                            homeViewModal.homeDataModal.searchText = sport
                        }
                        .frame(width: 100, height: 40)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .searchable(
            text: $homeViewModal.homeDataModal.searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search sports..."
        )
        .background(Color.white)
    }
}


#Preview {
    HomeTopSearchAndList()
        .environmentObject(HomeViewModal())
}
