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
        VStack(alignment: .leading) {
            
            Image(homeCardsData.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 156, height: 82)
                .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))

               
            
            VStack {
                HStack {
                    Text(homeCardsData.sportsName)
                        .font(Font.custom(.fontJakarta, size: 12))
                        .frame(width: 102, height: 16)
                        .padding(.trailing, 10)

                    Image(homeCardsData.starImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)

                    Text(homeCardsData.rating)
                        .font(Font.custom(.fontJakarta, size: 12))
                        .padding(.leading, -7)
                }

                HStack(spacing: -2) {
                    Image(homeCardsData.locationImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)

                    Text(homeCardsData.location)
                        .font(Font.custom(.fontJakarta, size: 12))
                        .frame(width: 78, height: 20)
                        .foregroundStyle(.font)
                }
                .frame(width: 156, alignment: .leading)
            }
        }
        .padding(8)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.disabledButton.opacity(0.4) , lineWidth: 1)
        )
    }
}

#Preview {
    ReusableCards(homeCardsData: HomeCardsDataModal(imageName: "CardsFootball", sportsName: "Formula F1 Racing", locationImage: "CardsPin", location: "Delhi / 35km", starImage: "Cardsrating", rating: "4.1"))
}
