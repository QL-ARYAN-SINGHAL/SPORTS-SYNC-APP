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
    @EnvironmentObject var tabRouter : TabRouter
    var body: some View {
        NavigationStack {

            CreatePostHeading()
                .environmentObject(tabRouter)


            Spacer()

            PhotoVideoPickerFooter()

                .navigationBarBackButtonHidden()
        }
        .overlay {
            if feedViewModal.isUploading {
                ProgressView("Uploading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
                    .background(Color.black.opacity(0.5), in: RoundedRectangle(cornerRadius: 10))
                    .foregroundColor(.white)
            }
        }
        .environmentObject(feedViewModal)
        .environmentObject(firebaseValidation)
        
    }
}

#Preview {
    CreatePostParent()
}
