//
//  HomeGridSection.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 25/04/25.
//


//Responsiiblities : Creating a view where we have vertical scrolling for section category and horizontal scroll for cards


import SwiftUI

struct HomeGridSection: View {
    @StateObject var cardViewModal = CardViewModel()

    @State private var isNavigating = false
    
    let sectionTitles = ["Nearby", "Recommended", "Trending"]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sectionTitles, id: \.self) { title in
                    Section {
                        Text(title)
                            .font(Font.custom(.fontJakartaBold, size: 20))
                            .frame(width: 300, height: 30, alignment: .leading)
                            .listRowSeparator(.hidden)
                            .padding(.top, 10)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 12) {
                                ForEach(cardViewModal.cardsHomeData, id: \.self) { card in
                                    ReusableCards(cardData: card) {
                                        cardViewModal.selectCard(card)
                                        isNavigating = true
                                    }

                                }
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                    .onAppear {
                        cardViewModal.fetchAllCards()
                    }

                }
            }
            .listStyle(.plain)
            .navigationDestination(isPresented: $isNavigating) {
                PlanDescriptionView(cardViewModel: cardViewModal)
            }

        }
    }
}


#Preview {
    HomeGridSection()
}
