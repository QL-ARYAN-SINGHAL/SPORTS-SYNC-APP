//
//  CreatePostHeading.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 05/05/25.
//
//MARK: RESPONSIBILITY - CREATE POST HEADER SECTION
import SwiftUI
import FirebaseAuth

struct CreatePostHeading: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var feedViewModel: FeedViewModal
    @EnvironmentObject var firebaseValidation : FirebaseValidation

    @State private var errorMessage: String? = nil

    var body: some View {
        VStack {
           
            PostSection()
                .padding()

            if let errorMessage = feedViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 24)
                }
            }

            ToolbarItem(placement: .navigationBarLeading) {
                Text(verbatim: .createPostHeading)
                    .font(Font.custom(.fontJakartaBold, size: 18))
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    
                    guard let userSession = firebaseValidation.userSession else {
                        feedViewModel.errorMessage = "User not authenticated."
                        return
                    }
                    feedViewModel.uploadPostToFirebase(userId: userSession.uid)
                    dismiss()
                }) {
                    Text(verbatim: .postString)
                        .foregroundColor(.white)
                        .font(Font.custom("JakartaBold", size: 12))
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .background(Color.appTint)
                        .cornerRadius(6)
                }
                .disabled(feedViewModel.isUploading)
            }
        }
        .overlay {
            if feedViewModel.isUploading {
                ProgressView("Uploading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
                    .background(Color.black.opacity(0.5), in: RoundedRectangle(cornerRadius: 10))
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    CreatePostHeading()
        .environmentObject(FeedViewModal())
}
