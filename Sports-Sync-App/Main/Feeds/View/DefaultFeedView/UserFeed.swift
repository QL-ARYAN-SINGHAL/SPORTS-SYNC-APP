//
//  HomeView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 22/04/25.
//

import SwiftUI

struct FeedView: View {
    @StateObject var feedViewModal = FeedViewModal()
    @StateObject var firebaseValidation = FirebaseValidation()
    var body: some View {
        VStack(spacing : 25){
            
            FeedTextView()
            
            FeedButton()
        }
        .navigationBarBackButtonHidden()
        .environmentObject(feedViewModal)
        .environmentObject(firebaseValidation)
    }
}

#Preview {
    FeedView()
}
