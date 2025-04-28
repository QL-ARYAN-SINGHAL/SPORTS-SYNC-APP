//
//  ReusableCreatePlanCards.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 28/04/25.
//

import SwiftUI

struct ReusableCreatePlanCards: View {
    var imageName: String
    var cardText: String
    
    var body: some View {
        Button(action: {}, label: {
            VStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 37, height: 47)
                
                Text(cardText)
                    .font(.custom("PlusJakartaSans-Regular", size: 14))
                    .frame(width: 125, height: 24)
                    .foregroundStyle(.black)
            }
            .padding(.vertical, 10)
            .frame(width: 159, height: 104)
        })
        .background(Color(.disabledButton).opacity(0.25))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.disabledButton), lineWidth: 1)
        )
    }
}

#Preview {
    ReusableCreatePlanCards(imageName: "TeamSports", cardText: "Team Sports")
}
