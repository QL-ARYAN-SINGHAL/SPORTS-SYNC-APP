//
//  StadiumListSheet.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 30/04/25.
//

//MARK: Responsibility: Show user some popular courts where he can filter using searchbar and select the satdium
import SwiftUI

struct StadiumListSheet: View {
    
    //Property wrapper
    
    @ObservedObject var cardViewModel: CardViewModel
    @ObservedObject var eventInformationViewModal: EventInformationViewModal

  //MARK:  variable to filter our stadiums as per alphabetic order
    var filteredStadiums: [String] {
        
        let allStadiums = cardViewModel.cardsHomeData.map { $0.stadiumName }
        //allstadiums maps all the data present in our db
        let uniqueStadiums = Array(Set(allStadiums)).sorted()
        //unique stadium sorts the fetched stadium names in alphabetical order

        if eventInformationViewModal.eventInfoData.searchText.isEmpty {
            return uniqueStadiums
        } else {
            return uniqueStadiums.filter {
                $0.localizedCaseInsensitiveContains(eventInformationViewModal.eventInfoData.searchText)
            }
        }
    }

    var body: some View {
        
        NavigationStack {
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text(verbatim: .popularCourtsString)
                
                    .font(Font.custom(.fontJakartaBold, size: 18))
                    .frame(height: 20, alignment: .leading)
                    .padding(.horizontal)

                List {
                    
                    ForEach(filteredStadiums, id: \.self) {
                        
                        stadium in
                        
                        Button(action: {
                            
                            eventInformationViewModal.eventInfoData.selectedStadium = stadium

                            //matches the first occurence of similar stadium in array where we fetched
                            if let matchingCard = cardViewModel.cardsHomeData.first(where: {
                                $0.stadiumName == stadium
                            })
                            {
                                //here it shows the card of that macthed stadium
                                cardViewModel.selectCard(matchingCard)
                            }

                        })
                        {
                            HStack {
                                
                                Text(stadium)
                                
                                    .font(Font.custom(.fontJakarta, size: 15))
                                    .frame(height: 50, alignment: .leading)

                                Spacer()

                                if eventInformationViewModal.eventInfoData.selectedStadium == stadium
                               
                                {
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
    }
}

#Preview {
    StadiumListSheet(cardViewModel: CardViewModel(), eventInformationViewModal: EventInformationViewModal())
}
