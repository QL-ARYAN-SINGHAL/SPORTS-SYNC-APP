//
//  StadiumListSheet.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 30/04/25.
//
import SwiftUI

struct StadiumListSheet: View {
    //PropertyWrappers
    @ObservedObject var cardViewModel: CardViewModel
    @StateObject var stadiumListViewModel = StadiumListViewModel()
   
   
    //variables to filter the stadiums or track th etadiums
    var filteredStadiums: [String] {
        let allStadiums = cardViewModel.cardsHomeData.map
                          { $0.stadiumName }
        
        let uniqueStadiums = Array(Set(allStadiums)).sorted()

        if  stadiumListViewModel.selectedStadium.searchtext.isEmpty {return uniqueStadiums}
        
        else {
            return uniqueStadiums.filter
            { $0.localizedCaseInsensitiveContains( stadiumListViewModel.selectedStadium.searchtext) }
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
                        
                        Button(
                            action: {stadiumListViewModel.selectedStadium.selectedStadium = stadium}
                        )
                        {
                            HStack {
                                Text(stadium)
                                    .font(Font.custom(.fontJakarta, size: 15))
                                    .frame(height: 50, alignment: .leading)
                                
                                Spacer()
                                
                                if stadiumListViewModel.selectedStadium.selectedStadium == stadium {
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
            .searchable(text:  $stadiumListViewModel.selectedStadium.searchtext, prompt: "Select stadium ...")
        }
        .environmentObject(stadiumListViewModel)
    }
   
}


#Preview {
    StadiumListSheet(cardViewModel: CardViewModel())
}
