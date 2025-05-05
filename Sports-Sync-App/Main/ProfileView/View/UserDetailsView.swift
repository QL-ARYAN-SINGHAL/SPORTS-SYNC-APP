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
    @State private var userData: SignUpDataModel? = nil
    @State private var avatarImage: UIImage?
    @State var photoPickerItem: PhotosPickerItem?

    var body: some View {
        VStack {
            if let user = userData {

                Button(action: {}) {
                    HStack(spacing: 20) {
                        PhotosPicker(
                            selection: $photoPickerItem, matching: .images
                        ) {

                            Image(
                                uiImage: avatarImage ?? UIImage(
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
            userData = firebaseValidation.getUserData()
        }
        .onChange(of: photoPickerItem) { _, _ in
            Task {
                if let photoPickerItem,
                    let data = try? await photoPickerItem.loadTransferable(
                        type: Data.self)
                {
                    if let image = UIImage(data: data) {
                        avatarImage = image
                        await firebaseValidation.saveUserData(with: avatarImage)
                    }

                }
                photoPickerItem = nil
            }
        }

    }
}

#Preview {
    UserDetailsView()
        .environmentObject(FirebaseValidation())
}
