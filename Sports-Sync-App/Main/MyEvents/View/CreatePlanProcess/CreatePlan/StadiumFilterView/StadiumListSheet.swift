//
//  StadiumListSheet.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 30/04/25.
//

import SwiftUI

struct StadiumListSheet: View {
    @ObservedObject var cardViewModel: CardViewModel
    
    @State private var searchtext = ""
    
    @State var isSelected: Bool = false

    
    //MARK: array that takes stadiums names from the function
    var filteredStadiums: [String] {
        let allStadiums = cardViewModel.cardsHomeData.map { $0.stadiumName }
        let uniqueStadiums = Array(Set(allStadiums)).sorted()

        //to filter the stadiums as we write we have use .filter and caseSesitive
        if searchtext.isEmpty {
            return uniqueStadiums
        } else {
            return uniqueStadiums.filter { $0.localizedCaseInsensitiveContains(searchtext) }
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
                    ForEach(filteredStadiums, id: \.self) { stadium in
                        Button(action : {}){
                            Text(stadium)
                                .font(Font.custom(.fontJakarta, size: 15))
                                .frame(height: 50, alignment: .leading)
                        }
                           
                    }
                }
                .listStyle(.plain)
            }
            .onAppear {
                cardViewModel.fetchAllCards()
            }

            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchtext, prompt: "Select stadium ...")
        }
        
    }
}

#Preview {
    StadiumListSheet(cardViewModel: CardViewModel())
}
