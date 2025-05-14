//
//  UserDetailsView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 02/05/25.
//

import PhotosUI
import SwiftUI

struct UserDetailsView: View {
    @EnvironmentObject var firebaseValidation: FirebaseValidation
    @State var photoPickerItem: PhotosPickerItem?

    var body: some View {
        VStack {
            if let user = firebaseValidation.userData {

                Button(action: {
                    //In futuer a view will be added to display user prifle with all details in better way
                }) {
                    HStack(spacing: 20) {
                        PhotosPicker(
                            selection: $photoPickerItem, matching: .images
                        ) {
                            //uiImage is for rendering your image as in UIKit way
                            Image(
                                uiImage: firebaseValidation.avatarImage
                                    ?? UIImage(
                                        systemName: "person.crop.circle.fill")!
                            )
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(
                                    Color.gray.opacity(0.3), lineWidth: 1)
                            )
                            .shadow(radius: 4)

                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.firstName)
                                .font(Font.custom(.fontJakartaBold, size: 20))
                                .foregroundStyle(.black)

                            Text(user.signUpEmail)
                                .font(Font.custom(.fontJakarta, size: 14))
                                .foregroundStyle(.black)

                            HStack(spacing: 4) {
                                Text("\(Int(user.ageValue))")
                                    .font(Font.custom(.fontJakarta, size: 14))
                                    .foregroundStyle(.gray)

                                if let gender = user.selectedGender {
                                    Text(gender.rawValue)
                                        .font(
                                            Font.custom(.fontJakarta, size: 14)
                                        )
                                        .foregroundStyle(.gray)
                                }
                            }
                        }
                        .frame(width: 219, height: 100, alignment: .leading)
                    }

                }
                .frame(width: 343, height: 144)
                .padding(.leading, 16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray, lineWidth: 0.5))
            } else {
                Text("No user data available.")
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            
            firebaseValidation.userData = firebaseValidation.getUserData()
            if let imageData = UserDefaults.standard.data(forKey: "UserImage") {
                firebaseValidation.avatarImage = UIImage(data: imageData)

                if let data = firebaseValidation.avatarImage?.pngData() {
                    print(data, "Size")
                }
            }

        }

        .onChange(of: photoPickerItem) { newItem in
            if let item = newItem {
                Task {
                    if let data = try? await item.loadTransferable(
                        type: Data.self),
                        let image = UIImage(data: data)
                    {
                        await firebaseValidation
                            .uploadProfileImageAndSaveToFirestore(image)
                        await firebaseValidation.saveUserData(with: image)
                    }

                }
            }
        }
    }

}

#Preview {
    UserDetailsView()
        .environmentObject(FirebaseValidation())
}
