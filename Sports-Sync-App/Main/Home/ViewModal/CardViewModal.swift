//  CardViewModel.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 24/04/25.
//import FirebaseFirestore

import Foundation
import SwiftUI
import FirebaseFirestore

class CardViewModel: ObservableObject {

    private var db = Firestore.firestore()

    //Array consisting of the data to filter out as per categories orto access their respective description
    @Published var cardsHomeData: [HomeCardsDataModal] = []

    //category wise cards array
    @Published var nearbyCards: [HomeCardsDataModal] = []
    @Published var trendingCards: [HomeCardsDataModal] = []
    @Published var recommendedCards: [HomeCardsDataModal] = []

    //filtered card logic where flteredcards = Filterednearby + FilteredTrending + FilteredRecommended
    @Published var filteredCards: [HomeCardsDataModal] = []
    @Published var filteredNearbyCards: [HomeCardsDataModal] = []
    @Published var filteredRecommendedCards: [HomeCardsDataModal] = []
    @Published var filteredTrendingCards: [HomeCardsDataModal] = []

    @Published var selectedCard: HomeCardsDataModal?
    @Published var homeDataModal = HomeCardsDataModal()

    //MARK: - FUNCTIONS

    //PARTICULAR CARD SELECTED LOGIC
    func selectCard(_ card: HomeCardsDataModal) {
        selectedCard = card
    }

    //FUNCTION TO FETCH ALL CARDS FROM DATABASE
    func fetchHomeCards() {
        db.collection("cards").getDocuments { snapshot, error in
            if let error = error {
                print(
                    "Error fetching cards collection: \(error.localizedDescription)"
                )
                return
            }

            guard let documents = snapshot?.documents else {
                print("No documents found in cards collection")
                return
            }

            var allCards: [HomeCardsDataModal] = []
            var nearby: [HomeCardsDataModal] = []
            var trending: [HomeCardsDataModal] = []
            var recommended: [HomeCardsDataModal] = []

            for document in documents {
                guard
                    let cardsData = document.data()["cards"]
                        as? [String: [String: Any]]
                else {
                    print(
                        "Cards field missing in document \(document.documentID)"
                    )
                    continue
                }

                var sectionCards: [HomeCardsDataModal] = []

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
                    allCards.append(card)
                    sectionCards.append(card)
                }

                switch document.documentID.lowercased() {
                case "nearby": nearby = sectionCards
                case "trending": trending = sectionCards
                case "recommended": recommended = sectionCards
                default: break
                }
            }

            DispatchQueue.main.async {
                self.cardsHomeData = allCards
                self.filteredCards = allCards
                self.nearbyCards = nearby
                self.trendingCards = trending
                self.recommendedCards = recommended
                self.filteredNearbyCards = self.nearbyCards
                self.filteredRecommendedCards = self.recommendedCards
                self.filteredTrendingCards = self.trendingCards

            }
        }
    }

    //Function to filter the cards as per spots name
    func filterCards(by sport: String?) {
        if let sport = sport, !sport.isEmpty {
            // Filter cards for each category based on sport
            filteredNearbyCards = nearbyCards.filter { $0.sportsName == sport }
            filteredRecommendedCards = recommendedCards.filter {
                $0.sportsName == sport
            }
            filteredTrendingCards = trendingCards.filter {
                $0.sportsName == sport
            }
        } else {
            // If no sport is selected, return all cards for each category
            filteredNearbyCards = nearbyCards
            filteredRecommendedCards = recommendedCards
            filteredTrendingCards = trendingCards
        }

        // Optional: Update a general filtered cards array if you want a unified view
        filteredCards =
            filteredNearbyCards + filteredRecommendedCards
            + filteredTrendingCards
    }

    //to return cards with filtered sports category wise
    func cards(for title: String) -> [HomeCardsDataModal] {
        switch title {
        case "Nearby":
            return filteredNearbyCards
        case "Trending":
            return filteredTrendingCards
        case "Recommended":
            return filteredRecommendedCards
        default:
            return []
        }
    }

}
