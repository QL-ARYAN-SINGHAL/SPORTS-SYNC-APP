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
                        .lineLimit(5)

                    if feedViewModal.feedData.captionPost.isEmpty {
                        Text("Write something about this post...")
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 14)
                    }
                }

                if let image = feedViewModal.feedData.localImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 343)
                        .padding(4)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10).stroke(
                                Color.clear))
                       
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
