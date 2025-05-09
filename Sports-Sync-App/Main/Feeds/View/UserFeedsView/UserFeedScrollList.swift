//
//  UserFeedScrollList.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 08/05/25.
//
import SwiftUI

struct UserFeedScrollList: View {
    @EnvironmentObject var feedViewModal: FeedViewModal
    @EnvironmentObject var firebaseValidation: FirebaseValidation

    var body: some View {
        VStack(spacing: 20) {
            if feedViewModal.userPosts.isEmpty {
                Text("No posts to show.")
                    .foregroundColor(.gray)
            } else {

                ForEach(feedViewModal.userPosts, id: \.uniqueID) { post in
                    UserPostsList(post: post)
                        .environmentObject(firebaseValidation)

                }
            }
        }
        .padding()
    }
}

#Preview {
    UserFeedScrollList()
        .environmentObject(FirebaseValidation())
        .environmentObject(FeedViewModal())
}
