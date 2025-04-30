//
//  StadiumListViewModal.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 30/04/25.
//
import SwiftUI
import FirebaseFirestore

class StadiumListViewModel: ObservableObject {
    @Published var stadiumListData: [StadiumListDataModal] = []
    let db = Firestore.firestore()

    func fetchStadiumList() {
        let docRef = db.collection("Stadiums").document("Popular Stadiums")

        docRef.getDocument { document, error in
            if let error = error {
                print("Error fetching document: \(error.localizedDescription)")
                return
            }

            guard let document = document, document.exists else {
                print("Document does not exist")
                return
            }

            guard let data = document.data(),
                  let stadiumArray = data["stadiums"] as? [[String: Any]] else {
                print("Invalid or missing stadium array")
                return
            }

            var fetchedStadiums: [StadiumListDataModal] = []

            for item in stadiumArray {
                if let stadiumName = item["stadium"] as? String {
                    let stadium = StadiumListDataModal(stadium: stadiumName)
                    fetchedStadiums.append(stadium)
                }
            }

            DispatchQueue.main.async {
                self.stadiumListData = fetchedStadiums
            }
        }
    }
}


