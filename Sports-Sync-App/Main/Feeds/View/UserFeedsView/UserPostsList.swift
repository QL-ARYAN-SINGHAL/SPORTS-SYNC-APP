//
//  UserPostsList.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 08/05/25.
// Updated UserPostsList.swift
import SwiftUI

struct UserPostsList: View {
    var post: FeedDataModal
   
    @EnvironmentObject var feedViewModal: FeedViewModal
    @Binding var selectedOption: String
    
    // Get the current user's profile image
    var userProfileImage: UIImage {
        if let profileImageURL = post.profileImageURL,
           let imageData = Data(base64Encoded: profileImageURL),
           let image = UIImage(data: imageData) {
            return image
        } else {
            return UIImage(systemName: "person.crop.circle.fill")!
            
        }
    }
    
    var body: some View {
        Group {
            if let user = FirebaseValidation.firebaseInstance.currentUser {
                let isOwner = user.id == post.id
                let isLiked = post.likedUsers?.contains(user.id) ?? false
                
                VStack(spacing: 15) {
                    ReusablePostListHeader(
                        userName: post.displayName,
                        postTime: post.postTime,
                        userImage: userProfileImage, 
                        isOwner: isOwner,
                        onDelete: {
                            feedViewModal.deleteUserPost(post: post)
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
                        isLiked: isLiked,
                        isCommented: false,
                        isShared: false,
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
                .onAppear {
                    Task {
                        await feedViewModal.fetchUserPostsAsync(
                            userId: user.id
                        )
                    }
                }
            } else {
                Text("User not logged in.")
                    .foregroundColor(.gray)
            }
        }
    }
}
