//
//  HomeView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 22/04/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var cardViewModal = CardViewModel()
    @StateObject var eventViewModal = EventInformationViewModal()

    var body: some View {

        VStack {
            HomeSearchAndList()

            HomeGridSection()

        }

        .environmentObject(cardViewModal)
        .environmentObject(eventViewModal)

    }
}

#Preview {
    HomeView()
}
