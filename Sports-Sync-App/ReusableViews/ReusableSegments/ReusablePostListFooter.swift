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
    @State private var isLiked: Bool = false
    @State private var isCommented: Bool = false
    @State private var isShared: Bool = false
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
                    isLiked.toggle()
                    likeAction()
                }) {
                    Image(systemName: "hand.thumbsup")
                        .font(.subheadline)
                        .foregroundColor(isLiked ? .white: .black)
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

#Preview {
   
    ReusablePostListFooter(
        commentCount: 10,
        likeCount: 4,
        likeAction: { print("Liked!") },
        commentAction: { print("Commented!") },
        shareAction: { print("Shared!") }
    )
}
