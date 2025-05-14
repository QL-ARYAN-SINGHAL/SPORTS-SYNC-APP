import FirebaseAuth
//
//  HomeView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 22/04/25.
//
import SwiftUI

struct FeedView: View {
    @StateObject var feedViewModal = FeedViewModal()
    let firebaseValidation = FirebaseValidation.firebaseInstance

    var body: some View {
        VStack {
            if feedViewModal.hasPostedBefore {
                VStack {
                    UserFeedParent()

                }

            } else {
                VStack(spacing: 25) {
                    FeedTextView()
                    FeedButton()
                }
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

    }
}

#Preview {
    FeedView()
}
