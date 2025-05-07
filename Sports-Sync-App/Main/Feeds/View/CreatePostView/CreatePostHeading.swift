//
//  CreatePostHeading.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 05/05/25.
//
//MARK: RESPONSIBILITY - CREATE POST HEADER SECTION

import SwiftUI

struct CreatePostHeading: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        HStack(spacing: 12) {
            Button(action: { dismiss() }) {
                ImageConstants.navigationBackImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 24)
            }

            Text(verbatim: .createPostHeading)
                .font(Font.custom(.fontJakartaBold, size: 18))
                .frame(width: 150, height: 28,alignment: .leading)

            Spacer()

            Button(action: {
                // Save caption and image to Firebase here on click
            }) {
                Text(verbatim: .postString)
                    .foregroundColor(.white)
                    .font(Font.custom(.fontJakartaBold, size: 10))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.appTint)

            }

        }
        .padding(.horizontal, 30)
        .padding(.vertical, 20)
        Divider()

    }
}

#Preview {
    CreatePostHeading()
}
