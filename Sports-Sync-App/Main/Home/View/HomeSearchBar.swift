//
//  HomeSearchBar.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 23/04/25.
//

import SwiftUI

struct HomeSearchBar: View {
    
    @EnvironmentObject var homeViewModal : HomeViewModal
    
    let names = ["Badminton" , "Cricket" , "Volleyball" , "Tennis" , "Football" , "Hockey" , "Basketball" , "Swimming"]
   
    var body: some View {
        NavigationStack {
        
        }
        .searchable(text: $homeViewModal.homeDataModal.searchText)
    }
    
    
}

#Preview {
    HomeSearchBar()
}
