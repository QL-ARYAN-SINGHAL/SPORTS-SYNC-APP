//
//  HomeView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 22/04/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModal()
    
    var body: some View {
        
            VStack{
                HomeSearchBar()
                    .environmentObject(viewModel)
            }
    }
}

#Preview {
    HomeView()
}
