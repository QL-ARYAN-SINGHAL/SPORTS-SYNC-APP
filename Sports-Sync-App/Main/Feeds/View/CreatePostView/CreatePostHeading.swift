//
//  CreatePostHeading.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 05/05/25.
//
//MARK: RESPONSIBILITY - CREATE POST HEADER SECTION

import SwiftUI

struct CreatePostHeading: View {
    var body: some View {
        VStack {
            PostSection()
            Spacer()
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    // dismiss action here
                }) {
                    ImageConstants.navigationBackImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 24)
                }
            }

            ToolbarItem(placement: .navigationBarLeading) {
                Text(verbatim: .createPostHeading)
                    .font(Font.custom(.fontJakartaBold, size: 18))
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // Save to Firebase
                }) {
                    Text(verbatim: .postString)
                        .foregroundColor(.white)
                        .font(Font.custom(.fontJakartaBold, size: 12))
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .background(Color.appTint)
                        .cornerRadius(6)
                }
            }
        }
    }
}

#Preview {
    CreatePostHeading()
        .environmentObject(FeedViewModal())
}
