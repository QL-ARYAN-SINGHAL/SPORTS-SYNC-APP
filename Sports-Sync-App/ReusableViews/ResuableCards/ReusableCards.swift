//
//  ReusableCards.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 24/04/25.
//

import SwiftUI

struct ReusableCards: View {
    
    var cardData: HomeCardsDataModal
    var onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: cardData.imageName)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 156, height: 82)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 7))
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 156, height: 82)
                            .clipShape(RoundedRectangle(cornerRadius: 7))
                    case .failure(_):
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 156, height: 82)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 7))
                    @unknown default:
                        EmptyView()
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(cardData.sportsName)
                            .font(Font.custom(.fontJakarta, size: 12))
                            .frame(width: 102, height: 16, alignment: .leading)
                        
                        Image(systemName: "star.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.yellow)
                        
                        Text(cardData.rating)
                            .font(Font.custom(.fontJakarta, size: 12))
                            .padding(.leading, -7)
                    }
                    
                    HStack {
                        Image(systemName: "location.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14, height: 14)
                        
                        Text(cardData.location)
                            .font(Font.custom(.fontJakarta, size: 12))
                            .frame(width: 78, height: 20)
                            .foregroundColor(.gray)
                    }
                    .frame(width: 156, alignment: .leading)
                }
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
            )
        }
        .buttonStyle(.plain) 
    }
}


#Preview {
    ReusableCards(cardData: HomeCardsDataModal(
        imageName: "https://cdn.pixabay.com/photo/2023/08/12/08/46/ai-generated-8185136_960_720.png",
        sportsName: "Formula 1 Racing",
        location: "Delhi / 15km",
        rating: "4.5",
        description: "Sample Description",
        stadiumName: "Jakartala noida",
        eventDate : "2023-08-12",
        eventTime: "02:30 pm - 04:30 pm"
    ), onTap: {})
}
