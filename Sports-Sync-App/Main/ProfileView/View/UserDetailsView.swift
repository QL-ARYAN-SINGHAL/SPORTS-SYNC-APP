//
//  UserDetailsView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 02/05/25.
//

import SwiftUI

struct UserDetailsView: View {
    @StateObject var firebaseValidation = FirebaseValidation()
    @State private var userData: SignUpDataModel? = nil

    var body: some View {
        VStack {
            if let user = userData {
               
                Button(action: {}) {
                    HStack(spacing: 20) {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 76, height: 76)
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 0.5)
                            )

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
                                        .font(Font.custom(.fontJakarta, size: 14))
                                        .foregroundStyle(.gray)
                                }
                            }
                        }
                        .frame(width: 219, height: 100, alignment: .leading)
                    }
                    
                }
                .frame(width: 343, height: 144)
                .padding(.leading, 16)
                .overlay(RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray, lineWidth: 0.5))
            } else {
                Text("No user data available.")
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            userData = firebaseValidation.getUserData()
        }
    }
}

#Preview {
    UserDetailsView()
}
