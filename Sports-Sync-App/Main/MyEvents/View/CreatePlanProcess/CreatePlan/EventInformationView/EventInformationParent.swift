//
//  EventInformationParent.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 29/04/25.
//

import SwiftUI

struct EventInformationParent: View {
   
    @StateObject var eventInformationViewModel = EventInformationViewModal()

    var body: some View {
        NavigationStack {
            ScrollView {
                EventInformationTitle()

                    VStack(spacing: 16) {
                        EventInformationSearch()
                        EventInformationFields()
                    }
                    
                }
          
            .navigationBarBackButtonHidden(true)
            .searchable(text: $eventInformationViewModel.eventInfoData.searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
        .environmentObject(eventInformationViewModel)
        
    }
}

#Preview {
    EventInformationParent()
}
