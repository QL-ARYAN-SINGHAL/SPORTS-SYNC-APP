//
//  CardViewModal.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 24/04/25.
//

import SwiftUI

class CardViewModal : ObservableObject {
    @Published var cardsHomeData : [HomeCardsDataModal] = [
        HomeCardsDataModal(imageName: "CardsFootball", sportsName: "Formula F1 Racing", locationImage: "CardsPin", locationname: "Delhi / 35km", starImage: "Cardsrating", starRating: "4.1" ),
        
        HomeCardsDataModal(imageName: "CardsMotoRacing", sportsName: "Inter football Cup", locationImage: "CardsPin", locationname:"Delhi / 38km", starImage: "Cardsrating", starRating:"3.8" )
    ]
}

