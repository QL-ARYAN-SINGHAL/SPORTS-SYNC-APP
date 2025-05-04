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
        ZStack {
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
            
            if eventInformationViewModel.isSubmitting {
                ZStack {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                    
                    ProgressView("Creating Plan...")
                       .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .foregroundColor(.white)
                        .padding(24)
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(16)
                }
            }
        }
    }
}

#Preview {
    EventInformationParent()
}

#Preview {
    EventInformationParent()
}
