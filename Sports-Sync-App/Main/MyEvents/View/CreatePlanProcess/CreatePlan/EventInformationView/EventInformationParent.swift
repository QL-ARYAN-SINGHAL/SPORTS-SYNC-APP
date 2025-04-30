//
//  EventInformationParent.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 29/04/25.
//

import SwiftUI

struct EventInformationParent: View {
    @State private var searchText: String = ""

    var body: some View {
       
            VStack {
                
                EventInformation()
                NavigationStack {
                ScrollView {
                    EventInformationSearch()
                    
                    EventInformationFields()

                    
                }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            }
         
        }
        ActivatedButton(buttonText: .createPlanString, action: {})
          
    }
}

#Preview {
    EventInformationParent()
}
