//
//  CardViewModel.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 24/04/25.
//

//
//  CardViewModel.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 24/04/25.
//

import Foundation
import FirebaseFirestore

class CardViewModel: ObservableObject {
    
    private var db = Firestore.firestore()
    
    @Published var cardsHomeData: [HomeCardsDataModal] = []
    
    func fetchCards(from category: String) {
        let docRef = db.collection("cards").document(category)
        
        docRef.getDocument { document, error in
            if let error = error {
                print("Error fetching document: \(error.localizedDescription)")
                return
            }
            
            guard let document = document, document.exists else {
                print("Document does not exist")
                return
            }
            
            guard let cardsData = document.data()?["cards"] as? [String: [String: Any]] else {
                print("Cards field is missing or invalid")
                return
            }
            
            var fetchedCards: [HomeCardsDataModal] = []
            
            for (_, cardInfo) in cardsData {
                guard
                    let imageName = cardInfo["imageName"] as? String,
                    let sportsName = cardInfo["sportsName"] as? String,
                    let location = cardInfo["location"] as? String,
                    let rating = cardInfo["rating"] as? String,
                    let description = cardInfo["description"] as? String
                else {
                    print("Missing one of the required fields in card")
                    continue
                }
                
                let card = HomeCardsDataModal(
                    imageName: imageName,
                    sportsName: sportsName,
                    locationImage: "", // If you have no locationImage, leave empty
                    location: location,
                    starImage: "",     // Same for starImage
                    rating: rating,
                    description: description
                )
                fetchedCards.append(card)
            }
            
            DispatchQueue.main.async {
                self.cardsHomeData = fetchedCards
                print(self.cardsHomeData)
            }
        }
    }
}
