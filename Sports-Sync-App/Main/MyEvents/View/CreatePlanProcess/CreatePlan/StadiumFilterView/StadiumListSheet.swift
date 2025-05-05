//
//  StadiumListSheet.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 30/04/25.
//

//MARK: Responsibility: Show user some popular courts where he can filter using searchbar and select the satdium
import SwiftUI

struct StadiumListSheet: View {

    @ObservedObject var cardViewModel: CardViewModel
    @ObservedObject var eventInformationViewModal: EventInformationViewModal
    @Binding var isPresented: Bool

    var filteredStadiums: [String] {
        let allStadiums = cardViewModel.cardsHomeData.map { $0.stadiumName }
        let uniqueStadiums = Array(Set(allStadiums)).sorted()

        if eventInformationViewModal.eventInfoData.searchText.isEmpty {
            return uniqueStadiums
        } else {
            return uniqueStadiums.filter {
                $0.localizedCaseInsensitiveContains(eventInformationViewModal.eventInfoData.searchText)
            }
        }
    }

    var body: some View {
        ZStack(alignment: .top) {
            NavigationStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(verbatim: .popularCourtsString)
                        .font(Font.custom(.fontJakartaBold, size: 18))
                        .frame(height: 20, alignment: .leading)
                        .padding(.horizontal)

                    List {
                        ForEach(filteredStadiums, id: \.self) { stadium in
                            Button(action: {
                                eventInformationViewModal.eventInfoData.selectedStadium = stadium
                                if let matchingCard = cardViewModel.cardsHomeData.first(where: {
                                    $0.stadiumName == stadium
                                }) {
                                    cardViewModel.selectCard(matchingCard)
                                }
                            }) {
                                HStack {
                                    Text(stadium)
                                        .font(Font.custom(.fontJakarta, size: 15))
                                        .frame(height: 50, alignment: .leading)
                                    Spacer()
                                    if eventInformationViewModal.eventInfoData.selectedStadium == stadium {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundStyle(.green)
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                }
                .onAppear {
                    cardViewModel.fetchAllCards()
                }
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $eventInformationViewModal.eventInfoData.searchText, prompt: "Select stadium ...")
            }

            
            Button(action: {
                isPresented = false
            }) {
                // fix the floating circle
                Image(systemName: "xmark")
                    .font(.system(size: 18, weight: .bold))
                    .background{
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.background)
                    }
            }
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }
}

