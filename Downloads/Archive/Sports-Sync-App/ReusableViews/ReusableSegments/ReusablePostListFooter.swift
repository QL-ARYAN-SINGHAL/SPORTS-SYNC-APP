//
//  ReusablePostListFooter.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 08/05/25.
//
import SwiftUI

struct ReusablePostListFooter: View {
    
    var commentCount: Int
    var likeCount: Int
    var isLiked: Bool
    var isCommented: Bool
    var isShared: Bool // Keep this as a parameter
    var likeAction: () -> Void
    var commentAction: () -> Void
    var shareAction: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("\(likeCount) Likes")
                Spacer()
                Text("\(commentCount) Comments")
            }
            .foregroundStyle(.gray)
            .font(.caption)
            .frame(width: 319)

            HStack(spacing: 20) {
                Button(action: {
                    likeAction() // Just call the action without toggling `isLiked` here
                }) {
                    Image(systemName: "hand.thumbsup")
                        .font(.subheadline)
                        .foregroundColor(isLiked ? .white : .black)
                        .padding(8)
                        .background(
                            Circle()
                                .fill(isLiked ? Color.blue : Color.blue.opacity(0.1))
                        )
                }

                Button(action: {
                    commentAction()
                }) {
                    Image(systemName: "ellipsis.bubble")
                        .foregroundColor(.gray)
                        .padding(8)
                        .background(
                            Circle()
                                .fill(isCommented ? Color.blue : Color.blue.opacity(0.1))
                        )
                }

                Button(action: {
                    shareAction()
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.gray)
                        .padding(8)
                        .background(
                            Circle()
                                .fill(isShared ? Color.blue : Color.blue.opacity(0.1))
                        )
                }
            }
            .frame(width: 319, alignment: .leading)
        }
    }
}

//#Preview {
//    ReusablePostListFooter(
//        commentCount: 10,
//        likeCount: 4,
//        isLiked: true, // Provide the value of `isLiked`
//        likeAction: { print("Liked!") },
//        commentAction: { print("Commented!") },
//        shareAction: { print("Shared!") }
//    )
//}
