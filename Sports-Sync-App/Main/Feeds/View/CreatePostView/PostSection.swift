//
//  PostSection.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 05/05/25.

import SwiftUI

struct PostSection: View {
    @EnvironmentObject var feedViewModal: FeedViewModal

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {

                ZStack(alignment: .topLeading) {
                    TextEditor(text: $feedViewModal.feedData.captionPost)
                        .font(Font.custom(.fontJakarta, size: 15))
                        .accentColor(.black)
                        .frame(width: 343, height: 100)
                        .padding(4)
                        .background(Color.white)
                        .cornerRadius(6)
                        .onChange(of: feedViewModal.feedData.captionPost) { newValue in
                            let lines = newValue.components(separatedBy: .newlines)
                            if lines.count > 5 {
                                feedViewModal.feedData.captionPost = lines.prefix(5).joined(separator: "\n")
                            }
                        }


                    if feedViewModal.feedData.captionPost.isEmpty {
                        Text("Write something about this post...")
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 14)
                    }
                }

                if let image = feedViewModal.feedData.localImage {
                    ZStack(alignment: .topTrailing) {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 343)
                            .padding(4)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10).stroke(Color.clear)
                            )

                        Button(action: {
                            feedViewModal.feedData.localImage = nil
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.gray)
                                .frame(width: 24, height: 24)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 1)
                        }
                        .padding(8)
                    }
                }

            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
        }
        //to dismiss the keyboard when scrolled outside the scrollView
        .scrollDismissesKeyboard(.interactively)
    }
}

#Preview {
    PostSection()
        .environmentObject(FeedViewModal())
}
