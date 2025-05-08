//
//  UserPostsList.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 08/05/25.
// Updated UserPostsList.swift

import SwiftUI

struct UserPostsList: View {
    let post: FeedDataModal

    @EnvironmentObject var firebaseValidation: FirebaseValidation

    var body: some View {
        if let user = firebaseValidation.currentUser {
            VStack(spacing: 15) {
                ReusablePostListHeader(
                    userName: user.firstName,
                    postTime: post.postTime,
                    userImage: firebaseValidation.avatarImage
                )

                ReusablePostListMid(
                    postCaption: post.captionPost,
                    postImage: post.localImage
                )

                ReusablePostListFooter(
                    commentCount: 20,
                    likeCount: post.postLike,
                    likeAction: {},
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
    UserPostsList(post: FeedDataModal())
        .environmentObject(FirebaseValidation())
        .environmentObject(FeedViewModal())
}
