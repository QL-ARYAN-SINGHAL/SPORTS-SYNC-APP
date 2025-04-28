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
                HomeTopSearchAndList()
            
                HomeGridSection()
                
                
            }
            .environmentObject(homeViewModel)
       
           
    }
}

#Preview {
    HomeView()
}
