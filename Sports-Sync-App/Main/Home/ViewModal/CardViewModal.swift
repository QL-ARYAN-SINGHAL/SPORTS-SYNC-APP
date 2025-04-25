//
//  CardViewModal.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 24/04/25.
//

import SwiftUI

class CardViewModal : ObservableObject {
    @Published var cardsHomeData : [HomeCardsDataModal] = [
        HomeCardsDataModal(imageName: "CardsFootball", sportsName: "FormulaF1Racing", locationImage: "CardsPin", location: "Delhi / 35km", starImage: "Cardsrating", rating: "4.1" ),
        
        HomeCardsDataModal(imageName: "CardsMotoRacing", sportsName: "Inter football Cup", locationImage: "CardsPin", location:"Delhi / 38km", starImage: "Cardsrating", rating:"3.8" )
    ]
}

