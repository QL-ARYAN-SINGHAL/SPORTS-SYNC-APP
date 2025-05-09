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
    var selectedOption: String

    @State private var previousSelection: String = ""

    var filteredPosts: [FeedDataModal] {
        switch selectedOption {
        case "My Feed":
            return feedViewModal.userPosts.filter {
                $0.id == firebaseValidation.currentUser?.id
            }
        case "General":
            return feedViewModal.universalPosts
        default:
            return feedViewModal.userPosts
        }
    }

    var body: some View {
        VStack(spacing: 20) {
            if filteredPosts.isEmpty {
                Text("No posts to show.")
                    .foregroundColor(.gray)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
            } else {
                ForEach(filteredPosts, id: \.uniqueID) { post in
                    UserPostsList(post: post)
                        .environmentObject(firebaseValidation)
                        .transition(.opacity.combined(with: .scale))
                }
            }
        }
        .padding()
        .animation(.easeInOut(duration: 0.3), value: selectedOption) 
    }
}



#Preview {
    UserFeedScrollList( selectedOption: "My Filter")
        .environmentObject(FirebaseValidation())
        .environmentObject(FeedViewModal())
}
