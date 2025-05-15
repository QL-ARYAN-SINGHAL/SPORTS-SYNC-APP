import SwiftUI

struct EventInformationSearch: View {

    @StateObject private var locationManager = LocationManager() // Use LocationManager as a state object

    // Property Wrappers
    @EnvironmentObject var eventInformationViewModel: EventInformationViewModal
    @StateObject var cardViewModal = CardViewModel()

    // States
    @State private var fetchedLocation: String = ""
    @State private var sheetNavigate: Bool = false
    @State private var showStadiumDetail: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Text when Tapped to select stadium
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.black.opacity(0.4))

                Text(verbatim: .searchPopularStadiumString)
                    .font(Font.custom(.fontJakarta, size: 14))
                    .frame(width: 300, alignment: .leading)
                    
                    .foregroundStyle(.black.opacity(0.3))
            }
            
            .padding(16)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
            )
            .cornerRadius(6)
            .frame(width: 351)

            // Logic to toggle between location and StadiumCard
            if !eventInformationViewModel.eventInfoData.showStadiumDetail {
                // Location is selected here
                HStack(spacing: 12) {

                    Button(action: {
                      
                        locationManager.requestLocation{ state in
                            fetchedLocation = state ?? "Unknown"
                            if fetchedLocation == "Unknown" {
                                eventInformationViewModel.eventInfoData.searchText = ""
                            }else{
                                eventInformationViewModel.eventInfoData.searchText = fetchedLocation
                            }
                        }
                    }) {
                        HStack(spacing: 10) {
                            Image(systemName: "paperplane.fill")
                                .frame(width: 13, height: 13)

                            Text(verbatim: .selectLocationString)
                                .font(Font.custom(.fontJakarta, size: 14))
                                .foregroundColor(.blue)
                            
                            Text(fetchedLocation)
                                .foregroundStyle(.black)
                                .font(Font.custom(.fontJakartaBold, size: 14))
                        }
                        .frame(height: 23)
                    }
                }
                .frame(width: 351, alignment: .leading)

                Spacer()
            } else {
                if let selectedCard = cardViewModal.selectedCard {
                    ZStack(alignment: .topTrailing) {
                        ReusableStadiumSmallCard(stadiumcardData: selectedCard)
                            .padding(.top, 8)

                        Button(action: {
                            cardViewModal.selectedCard = nil
                            eventInformationViewModel.eventInfoData.showStadiumDetail = false
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.gray)
                                .padding(8)
                        }
                    }
                }

            }
        }
        .onTapGesture {
            sheetNavigate.toggle()
        }
        .onAppear {
            // Fetch cards when the view appears
            cardViewModal.fetchHomeCards()
        }
        .onChange(of: cardViewModal.selectedCard) { newValue in
            if newValue != nil {
                eventInformationViewModel.eventInfoData.showStadiumDetail = true
                sheetNavigate = false
            }
        }
        .padding(.top, 8)
        .sheet(isPresented: $sheetNavigate) {
            StadiumListSheet(
                cardViewModel: cardViewModal,
                eventInformationViewModal: eventInformationViewModel,
                isPresented: $sheetNavigate
            )
            .presentationDetents([.height(UIScreen.main.bounds.height * 0.6)])
            .presentationDragIndicator(.hidden)
            .presentationCornerRadius(31)
        }
    }
}

#Preview {
    NavigationView {
        EventInformationSearch(cardViewModal: CardViewModel())
            .environmentObject(EventInformationViewModal())
    }
}
