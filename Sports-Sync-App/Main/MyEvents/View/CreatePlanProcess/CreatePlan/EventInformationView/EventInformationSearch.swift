//
//  EventInformationSearch.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 29/04/25.
//

import SwiftUI

struct EventInformationSearch: View {
    let userLocation = LocationManager()
    @EnvironmentObject var eventInformationViewModel: EventInformationViewModal
    @State private var fetchedLocation: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 12) {
                Button(
                    action: {
                        userLocation.requestState { state in
                            fetchedLocation = state ?? "Unknown"
                            
                            eventInformationViewModel.eventInfoData.searchText = fetchedLocation
                        }
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "paperplane.fill")
                                .frame(width: 13, height: 13)
                            
                            Text("Select Location on Map")
                                .font(Font.custom(.fontJakarta, size: 14))
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
    }
}

#Preview {
    NavigationView {
        EventInformationSearch()
            .environmentObject(EventInformationViewModal())
    }
}
