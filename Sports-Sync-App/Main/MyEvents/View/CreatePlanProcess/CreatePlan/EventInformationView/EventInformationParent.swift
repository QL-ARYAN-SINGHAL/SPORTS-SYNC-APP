//
//  EventInformationParent.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 29/04/25.
//

import SwiftUI

struct EventInformationParent: View {
   
    @StateObject var eventInformationViewModel = EventInformationViewModal()
    @StateObject var tabRouter = TabRouter()
   

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
        }
        .environmentObject(eventInformationViewModel)
        .environmentObject(tabRouter)
        
        
    }
}

#Preview {
    EventInformationParent()
}
