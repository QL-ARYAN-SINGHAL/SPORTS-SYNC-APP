//
//  HomeView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 22/04/25.
//
import SwiftUI
import FirebaseAuth

struct FeedView: View {
    @StateObject var feedViewModal = FeedViewModal()
    @StateObject var firebaseValidation = FirebaseValidation()
    @EnvironmentObject var tabRouter : TabRouter
    
    var body: some View {
        VStack {
            if !feedViewModal.hasPostedBefore {
                VStack(spacing: 25) {
                    FeedTextView()
                    FeedButton()
                }
               
            } else {
                UserFeedParent()
                
                   
                   
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            if let userId = Auth.auth().currentUser?.uid {
                feedViewModal.checkIfUserHasPosts(userId: userId)
            }
        }
        .environmentObject(feedViewModal)
        .environmentObject(firebaseValidation)
        .environmentObject(tabRouter)
       
    }
}


#Preview {
    FeedView()
}
