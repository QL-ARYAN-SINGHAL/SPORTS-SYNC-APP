//
//  ReusableCards.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 24/04/25.
//

import SwiftUI

struct ReusableCards: View {
    let homeCardsData : HomeCardsDataModal
    var body: some View {
        VStack{
            Image(homeCardsData.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .cornerRadius(10)
            
            Text(homeCardsData.sportsName)
                .font(Font.custom(.fontJakarta, size: 12))
                .frame(width: 102, height: 16, alignment: .leading)
            HStack{
                Image(homeCardsData.locationImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12 , height: 12)
            }
        }
    }
}

#Preview {
    ReusableCards(homeCardsData: HomeCardsDataModal(imageName: "CardsFootball", sportsName: "Formula F1 Racing", locationImage: "CardsPin", locationname: "Delhi / 35km", starImage: "Cardsrating", starRating: "4.1" ))
}
