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
   
    var searchResults: [String] {
        if homeViewModal.homeDataModal.searchText.isEmpty {
            return names
        } else {
            return names.filter { $0.contains(homeViewModal.homeDataModal.searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { name in
                    NavigationLink {
                        Text(name)
                    } label: {
                        Text(name)
                    }
                }
            }
        
        }
        .searchable(text: $homeViewModal.homeDataModal.searchText) {
            ForEach(searchResults, id: \.self) { result in
                Text("\(result)").searchCompletion(result)
            }
        }
    }
    
    
}

#Preview {
    HomeSearchBar()
}
