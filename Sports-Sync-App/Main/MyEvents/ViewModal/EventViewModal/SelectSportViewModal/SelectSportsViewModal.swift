//
//  SelectSportsViewModal.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 29/04/25.
//

import FirebaseFirestore
//MARK: RESPONSIBILITY : PUBLISHING THE CHANGES MADE IN DATA MODAL AND FETCH DETAILS FROM DATABASE TO BE STORED IN DATA MODAL
import SwiftUI

class SelectSportsViewModal: ObservableObject {

    private var db = Firestore.firestore()
    @Published var selectSportsData: [SelectSportDataModal] = []

    func fetchSelectSports() {
        let docRef = db.collection("CreatePlan").document("Select Sports")

        docRef.getDocument { document, error in
            if let error = error {
                print("Error fetching document: \(error.localizedDescription)")
                return
            }

            guard let document = document, document.exists else {
                print("Document does not exist")
                return
            }

            guard
                let selectSportsData = document.data()
                    as? [String: [String: Any]]
            else {
                print("Sports information is missing or invalid")
                return
            }

            var fetchedSports: [SelectSportDataModal] = []

            for (_, sportInfo) in selectSportsData {
                guard
                    let sportsName = sportInfo["sportsName"] as? String,
                    let sportsImage = sportInfo["sportsImage"] as? String
                else {
                    print("Missing one of the required fields in card")
                    continue
                }

                let sport = SelectSportDataModal(
                    sportsName: sportsName,
                    sportsImage: sportsImage
                )
                fetchedSports.append(sport)
            }

            DispatchQueue.main.async {
                self.selectSportsData = fetchedSports
            }
        }
    }

}

