//
//  EventInformationParent.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 29/04/25.
//

import SwiftUI

struct EventInformationParent: View {

    @StateObject var eventInformationViewModel = EventInformationViewModal()
    @EnvironmentObject var tabRouter : TabRouter
    @StateObject var firebaseValidation = FirebaseValidation()

    var body: some View {
        ZStack {
            NavigationStack {
                ScrollView {
                    EventInformationTitle()

                    VStack(spacing: 16) {
                        EventInformationSearch()
                        EventInformationFields()
                            .environmentObject(tabRouter)
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
            .environmentObject(eventInformationViewModel)
            .environmentObject(firebaseValidation)
            .overlay {
                if eventInformationViewModel.isSubmitting {
                    ZStack {
                        Color.black.opacity(0.4).ignoresSafeArea()
                        ProgressView("Please wait...")
                            .progressViewStyle(
                                CircularProgressViewStyle(tint: .white)
                            )
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
}

#Preview {
    EventInformationParent()
}


