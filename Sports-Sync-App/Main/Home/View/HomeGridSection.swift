//
//  HomeGridSection.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 25/04/25.
//

import SwiftUI

struct HomeGridSection: View {
    @ObservedObject var cardViewModel = CardViewModal()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        List{
            
            Text("Nearby")
                .font(Font.custom(.fontJakarta, size: 20))
                .frame(width: 320 , height: 40 , alignment: .leading)
            ScrollView(Axis.Set.horizontal, showsIndicators: false){
                LazyVGrid(columns: columns, spacing: 16) {
                    
                    ForEach(cardViewModel.cardsHomeData, id: \.id) { card in
                        
                        ReusableCards(homeCardsData: card)
                        
                    }
                    
                    
                }
                .padding(.leading, 20)
            }
            
            Text("Trending ")
                .font(Font.custom(.fontJakarta, size: 20))
                .frame(width: 320 , height: 40 , alignment: .leading)
            ScrollView(Axis.Set.horizontal, showsIndicators: false){
                LazyVGrid(columns: columns, spacing: 16) {
                    
                    ForEach(cardViewModel.cardsHomeData, id: \.id) { card in
                        
                        ReusableCards(homeCardsData: card)
                        
                    }
                    
                    
                }
                .padding(.leading, 20)
            }
        }
    }
}

#Preview {
    HomeGridSection()
}
