//
//  ReusableCreatePostSection.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 08/05/25.

import SwiftUI

struct UserPostCreationSection: View {
    
    @EnvironmentObject var firebaseValidation : FirebaseValidation
    @State private var navigateToCreatePost = false
    @EnvironmentObject var tabRouter: TabRouter
    var body: some View {
        VStack {
            NavigationLink(destination: CreatePostParent().environmentObject(tabRouter).environmentObject(firebaseValidation), isActive: $navigateToCreatePost) {
                            EmptyView()
                        }
                        .hidden() // Hides the link view
                        
            
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
                    ReusablePhotoVideoPicker(iconName: "camera.fill", labelText: .cameraString)
                    ReusablePhotoVideoPicker(iconName: "photo.fill.on.rectangle.fill", labelText: .photoVideoString)
                }
                .frame(width: 343, height: 40, alignment: .leading)
            }
            .onTapGesture {
                navigateToCreatePost = true
              
            }
        }
        .frame(width: 343, height: 74)
        .padding(.vertical , 30)
        .environmentObject(firebaseValidation)
        .environmentObject(tabRouter)
       
    }
}

#Preview {
    NavigationStack {
        UserPostCreationSection()
            .environmentObject(FirebaseValidation())
    }
}
