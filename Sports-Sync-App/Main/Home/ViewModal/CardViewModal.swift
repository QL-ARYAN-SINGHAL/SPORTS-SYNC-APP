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
    @Published var selectedCard: HomeCardsDataModal?

    func selectCard(_ card: HomeCardsDataModal) {
        selectedCard = card
    }

    func fetchAllCards() {
        db.collection("cards").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching cards collection: \(error.localizedDescription)")
                return
            }

            guard let documents = snapshot?.documents else {
                print("No documents found in cards collection")
                return
            }

            var fetchedCards: [HomeCardsDataModal] = []

            for document in documents {
                guard let cardsData = document.data()["cards"] as? [String: [String: Any]] else {
                    print("Cards field missing in document \(document.documentID)")
                    continue
                }

                for (_, cardInfo) in cardsData {
                    guard
                        let imageName = cardInfo["imageName"] as? String,
                        let sportsName = cardInfo["sportsName"] as? String,
                        let location = cardInfo["location"] as? String,
                        let rating = cardInfo["rating"] as? String,
                        let description = cardInfo["description"] as? String,
                        let stadiumName = cardInfo["stadiumName"] as? String,
                        let eventDate = cardInfo["eventDate"] as? String,
                        let eventTime = cardInfo["eventTime"] as? String
                    else {
                        continue
                    }

                    let card = HomeCardsDataModal(
                        imageName: imageName,
                        sportsName: sportsName,
                        location: location,
                        rating: rating,
                        description: description,
                        stadiumName: stadiumName,
                        eventDate: eventDate,
                        eventTime: eventTime
                    )
                    fetchedCards.append(card)
                }
            }

            DispatchQueue.main.async {
                self.cardsHomeData = fetchedCards
            }
        }
    }

}
