//
//  UserPostsList.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 08/05/25.
// Updated UserPostsList.swift

import SwiftUI
struct UserPostsList: View {
    var post: FeedDataModal
    @EnvironmentObject var firebaseValidation: FirebaseValidation
    @EnvironmentObject var feedViewModal: FeedViewModal

    var body: some View {
        if let user = firebaseValidation.currentUser {
            let isOwner = user.id == post.id

            VStack(spacing: 15) {
                ReusablePostListHeader(
                    userName: user.firstName,
                    postTime: post.postTime,
                    userImage: firebaseValidation.avatarImage,
                    isOwner: isOwner,
                    onDelete: {
                        print("Delete is pressed")
                    },
                    onReport: {
                       print("Report is pressed")
                    }
                )

                ReusablePostListMid(
                    postCaption: post.captionPost,
                    postImage: post.localImage
                )

                ReusablePostListFooter(
                    commentCount: 20,
                    likeCount: post.postLike,
                    likeAction: {
                        feedViewModal.toggleLike(for: post)
                    },
                    commentAction: {},
                    shareAction: {}
                )

            }
            .frame(width: 343)
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 0.5)
            )
        } else {
            Text("User not logged in.")
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    UserPostsList(post: FeedDataModal(captionPost: "Sample", postLike: 2))
        .environmentObject(FirebaseValidation())
}
