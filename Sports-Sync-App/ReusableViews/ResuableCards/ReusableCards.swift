//
//  ReusableCards.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 24/04/25.
//

import SwiftUI

struct ReusableCards: View {
    
    @State var cardData: HomeCardsDataModal?
    @StateObject var viewModel = CardViewModal()
    
    var body: some View {
        
            VStack(alignment: .leading) {
                Image(cardData?.imageName ?? "")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 156, height: 82)
                    .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                
                VStack {
                    HStack {
                        Text(cardData?.sportsName ?? "")
                            .font(Font.custom(.fontJakarta, size: 12))
                            .frame(width: 102, height: 16)
                            .padding(.trailing, 10)
                            
                        
                        Image(cardData?.starImage ?? "")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                        
                        Text(cardData?.rating ?? "")
                            .font(Font.custom(.fontJakarta, size: 12))
                            .padding(.leading, -7)
                    }
                    
                    HStack(spacing: -2) {
                        Image(cardData?.locationImage ?? "")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        
                        Text(cardData?.location ?? "")
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
            .task {
                await viewModel.fetchCards(for: "nearby")
            }
        }
    }

#Preview {
    ReusableCards(cardData: HomeCardsDataModal(imageName: "fgndfk", sportsName: "fghf", locationImage: "ghfj", location: "gjf", starImage: "fghf", rating: "fghg", description: "fbf"))
}
