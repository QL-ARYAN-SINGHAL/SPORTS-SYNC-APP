//
//  CreatePostParent.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 05/05/25.
//

import SwiftUI

struct CreatePostParent: View {
    @StateObject var feedViewModal = FeedViewModal()
    @EnvironmentObject var firebaseValidation : FirebaseValidation
    var body: some View {
        NavigationStack {

            CreatePostHeading()


            Spacer()

            PhotoVideoPickerFooter()

                .navigationBarBackButtonHidden()
        }
        .environmentObject(feedViewModal)
        .environmentObject(firebaseValidation)
        
    }
}

#Preview {
    CreatePostParent()
}
