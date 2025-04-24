//
//  HomeView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 22/04/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel = HomeViewModal()
    
    var body: some View {
        
            VStack{
                HomeSearchBar()
                HomeSportsListView()
            
                   
            }
            .environmentObject(homeViewModel)
       
           
    }
}

#Preview {
    HomeView()
}
