//
//  PostSection.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 05/05/25.
//
import SwiftUI

struct PostSection: View {
    @EnvironmentObject var feedViewModal: FeedViewModal
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            // User caption is entered here
            ZStack(alignment: .topLeading) {
                TextEditor(text: $feedViewModal.feedData.captionPost)
                    .focused($isFocused)
                    .font(Font.custom(.fontJakarta, size: 15))
                    .accentColor(.black)
                    .padding(4)
                    .background(Color.white)
                
                
                if feedViewModal.feedData.captionPost.isEmpty && !isFocused {
                    Text("Write something about this post...")
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 14)
                }
            }
            .frame(width: 343, height: 62)
            .padding(.vertical, 10)
            
            if let image = feedViewModal.localImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 343, height: 242)
                    .padding(4)
                    .clipped()
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(.clear))
            }
            
        }
    }
}
#Preview {
    PostSection()
        .environmentObject(FeedViewModal())
}

