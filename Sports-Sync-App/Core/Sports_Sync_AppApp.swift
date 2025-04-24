//
//  Sports_Sync_AppApp.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 11/04/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseAppCheck
import FirebaseCore


@main
struct Sports_Sync_AppApp: App {
    @StateObject var firebaseValidation = FirebaseValidation()
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ReusableCards(homeCardsData: HomeCardsDataModal(imageName: "CardsFootball", sportsName: "Formula F1 Racing", locationImage: "CardsPin", locationname: "Delhi / 35km", starImage: "Cardsrating", starRating: "4.1" ))
                .environmentObject(firebaseValidation)
            
        }
    }
}
