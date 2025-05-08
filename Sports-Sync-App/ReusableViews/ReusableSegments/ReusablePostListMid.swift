//
//  ReusablePostListMid.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 08/05/25.
//
import SwiftUI

struct ReusablePostListMid: View {
    var postCaption: String
    var postImage: UIImage?
    
    var body: some View {
        VStack(spacing: 8) {
            Text(postCaption)
                .font(Font.custom(.fontJakarta, size: 17))
                .frame(maxWidth: 319, alignment: .leading)
                .padding(.horizontal, 10)
                .padding(.top, 10)

            if let image = postImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 319, height: 174)
                    .cornerRadius(4)
            } else {
                Image(systemName: "photo.on.rectangle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundStyle(.gray)
                    .frame(width: 319, height: 174)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(4)
            }
        }
    }
}

#Preview {
    ReusablePostListMid(postCaption: "hello", postImage: nil)
}
