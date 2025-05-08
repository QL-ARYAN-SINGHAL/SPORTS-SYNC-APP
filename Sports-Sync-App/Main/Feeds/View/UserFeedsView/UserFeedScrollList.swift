//
//  UserFeedScrollList.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 08/05/25.
//
import SwiftUI

struct UserFeedScrollList: View {
    @ObservedObject var feedViewModal: FeedViewModal
    @EnvironmentObject var firebaseValidation: FirebaseValidation

    var body: some View {
        VStack(spacing: 20) {
            if feedViewModal.userPosts.isEmpty {
                Text("No posts to show.")
                    .foregroundColor(.gray)
            } else {
                ForEach(feedViewModal.userPosts) { post in
                    UserPostsList(post: post)
                      
                }
            }
        }
        .padding()
    }
}

//#Preview {
//    UserFeedScrollList(feedViewModal: \.content)
//        .environmentObject(FirebaseValidation())
//        .environmentObject(FeedViewModal())
//}

