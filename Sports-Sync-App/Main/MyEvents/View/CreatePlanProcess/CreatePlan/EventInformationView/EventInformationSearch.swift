//
//  EventInformationSearch.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 29/04/25.
//

import SwiftUI

struct EventInformationSearch: View {
    let userLocation = LocationManager()
    
    //Property wrappe
 //   @EnvironmentObject var selectedStadiumList:StadiumListViewModel
    @EnvironmentObject var eventInformationViewModel: EventInformationViewModal
    
    //states
    @State private var fetchedLocation: String = ""
    @State private var sheetNavigate: Bool = false
    

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Tap to select stadium
            HStack {
                
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                Text("Select a basketball court")
                    .font(Font.custom(.fontJakarta, size: 14))
                    .frame(width: 300)
                    .onTapGesture {
                        sheetNavigate.toggle()
                    }
                
            }
            .padding(16)
            .background(Color(.systemGray6))
            .cornerRadius(6)
            .frame(width: 351)

            
            
            // Location selection
            HStack(spacing: 12) {
                Button(action: {
                    userLocation.requestState { state in
                        fetchedLocation = state ?? "Unknown"
                        eventInformationViewModel.eventInfoData.searchText = fetchedLocation
                    }
                }) {
                    HStack(spacing: 8) {
                        
                        Image(systemName: "paperplane.fill")
                            .frame(width: 13, height: 13)
                        

                        Text("Select location on map")
                            .font(Font.custom(.fontJakarta, size: 14))
                            .foregroundColor(Color.blue)
                    }
                    
                    

                    
                    .frame(height: 23)
                }

                if !fetchedLocation.isEmpty {
                    
                    Text(fetchedLocation)
                        .font(Font.custom(.fontJakartaBold, size: 15))
                        .foregroundColor(.black)
                        .lineLimit(1)
                }
            }
            
            .frame(width: 351, alignment: .leading)

            Spacer()
            
            
        }
        .padding(.top, 8)
        .sheet(isPresented: $sheetNavigate) {
            VStack(spacing:1){
                
                Image(systemName: "lock.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50 , height: 30)
                    .onTapGesture {
                        sheetNavigate = false
                    }
                
                StadiumListSheet(cardViewModel: CardViewModel())
            }
            
                .presentationDetents([.height(UIScreen.main.bounds.height*0.6)])
                .presentationDragIndicator(.hidden)
                .presentationCornerRadius(31)
        }
     

    }
}


#Preview {
    NavigationView {
        EventInformationSearch()
            .environmentObject(EventInformationViewModal())
          // .environmentObject(StadiumListViewModel())
    }
}
