//
//  HomeSearchBar.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 23/04/25.
//

//
//  HomeSearchBar.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 23/04/25.
//

//
//  HomeSearchBar.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 23/04/25.
//

//
//  HomeTopSearchAndList.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 24/04/25.
//

import SwiftUI

struct HomeTopSearchAndList: View {
    
    @EnvironmentObject var homeViewModal: HomeViewModal
    
    let sportsNames = ["Cricket", "Badminton", "Football", "Tennis", "Volleyball", "Hockey", "Basketball", "Swimming"]
    
    var body: some View {
     
            NavigationStack {
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            Button(action: {
                                homeViewModal.homeDataModal.searchText = ""
                            }) {
                                Text("All")
                                    .font(.custom(.fontJakarta, size: 14))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .background(Color(.appTint))
                                    .cornerRadius(10)
                            }
                            
                            ForEach(sportsNames, id: \.self) { sport in
                                ReusableListButtons(buttonText: sport) {
                                    
                                }
                                .frame(width: 100, height: 40)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 5)
                    
                    Spacer()
                }
                
            }
            .searchable(
                text: $homeViewModal.homeDataModal.searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search sports..."
            )
        }
    }


#Preview {
    HomeTopSearchAndList()
        .environmentObject(HomeViewModal())
}
