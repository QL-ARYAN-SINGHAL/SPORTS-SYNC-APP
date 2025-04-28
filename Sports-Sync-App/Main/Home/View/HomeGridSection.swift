//
//  HomeGridSection.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 25/04/25.
//
//Responsiiblities : Creating a view where we have vertical scrolling for section category and horizontal scroll for cards

//
//  HomeGridSection.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 25/04/25.
//

import SwiftUI

struct HomeGridSection: View {
    @StateObject var cardViewModal = CardViewModel()
    @State private var selectedCategory = "trending"

    let sectionTitles = ["nearby", "recommended", "trending"]

    var body: some View {
        List {
            ForEach(sectionTitles, id: \.self) { title in
                Section {
                    Text(title)
                        .font(Font.custom(.fontJakartaBold, size: 20))
                        .frame(width: 300,height : 30, alignment: .leading)
                        .listRowSeparator(.hidden)
                        .padding(.top,12)

                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 12) {
                            ForEach(cardViewModal.cardsHomeData, id: \.self) { card in
                                ReusableCards(cardData: card)
                                   
                            }
                        }
                        .padding(.horizontal)
                    }
                    .listRowSeparator(.hidden)
                }
                .onAppear {
                    cardViewModal.fetchCards(from: title)
                }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    HomeGridSection()
}
