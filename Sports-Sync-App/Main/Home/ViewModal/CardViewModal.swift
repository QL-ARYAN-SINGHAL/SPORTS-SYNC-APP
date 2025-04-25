//
//  CardViewModal.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 24/04/25.
//
import Foundation
import FirebaseFirestore

class CardViewModal: ObservableObject {
    
    private var db = Firestore.firestore()
    
    @Published var cardsHomeData : [HomeCardsDataModal] = []
    
    func fetchCards(for category: String) async {
      
        let docRef = db.collection("cards").document("nearby")

        do {
          let city = try await docRef.getDocument(as: HomeCardsDataModal.self)
          print("Sports: \(city)")
        } catch {
          print("Error decoding sports: \(error)")
        }

            }
        }
   
