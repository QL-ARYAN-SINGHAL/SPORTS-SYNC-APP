//
//  ReusableCreatePostSection.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 08/05/25.

import SwiftUI

struct UserPostCreationSection: View {

    let firebaseValidation = FirebaseValidation.firebaseInstance
    @State private var navigateToCreatePost = false

    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(
                    destination: CreatePostParent().environmentObject(
                        firebaseValidation), isActive: $navigateToCreatePost
                ) {
                    EmptyView()
                }
                .hidden()

                VStack {
                    if let user = firebaseValidation.currentUser {
                        Text("What's on your mind, \(user.firstName)?")
                            .font(Font.custom(.fontJakarta, size: 15))
                            .frame(width: 343, height: 39, alignment: .leading)
                            .foregroundStyle(.disabledFont)
                    } else {
                        Text("What's on your mind?")
                            .font(Font.custom(.fontJakarta, size: 15))
                            .frame(width: 343, height: 39, alignment: .leading)
                            .foregroundStyle(.disabledFont)
                    }

                    HStack {
                        ReusablePhotoVideoPicker(
                            iconName: "camera.fill", labelText: .cameraString)
                        ReusablePhotoVideoPicker(
                            iconName: "photo.fill.on.rectangle.fill",
                            labelText: .photoVideoString)
                    }
                    .frame(width: 343, height: 30, alignment: .leading)
                }
                .onTapGesture {
                    navigateToCreatePost = true
                }
            }
            .frame(width: 343, height: 34)
            .padding(.vertical, 30)
            .environmentObject(firebaseValidation)

        }
    }
}
#Preview {
    NavigationStack {
        UserPostCreationSection()
            .environmentObject(FirebaseValidation())
    }
}
