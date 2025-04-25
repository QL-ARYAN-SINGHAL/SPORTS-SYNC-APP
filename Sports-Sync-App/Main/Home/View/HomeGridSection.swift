//
//  HomeGridSection.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 25/04/25.
//
//Responsiiblities : Creating a view where we have vertical scrolling for section category and horizontal scroll for cards

import SwiftUI

struct HomeGridSection: View {
    @ObservedObject var cardViewModel = CardViewModal()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let sectionTitles = ["Nearby", "Trending","Recommended"]

    var body: some View {
        List {
            ForEach(sectionTitles, id: \.self) { title in
                Section {
                    Text(title)
                        .font(Font.custom(.fontJakartaBold, size: 20))
                        .frame(width: 300, height: 40, alignment: .leading)
                        .listRowSeparator(.hidden)

                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 12) {
                            ForEach(cardViewModel.cardsHomeData, id: \.self) { card in
//                                ReusableCards( category: "nearby")
                            }
                        }
                    }
                    .listRowSeparator(.hidden)
                }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    HomeGridSection()
}
