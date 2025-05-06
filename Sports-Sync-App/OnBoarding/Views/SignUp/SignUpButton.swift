//
//  SignUpButton.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 13/04/25.
//

import SwiftUI

struct SignUpButton: View {
    
    // MARK: - Environment Objects
    @EnvironmentObject var formViewModal: FormViewModal
    @EnvironmentObject var firebaseValidation: FirebaseValidation

    // MARK: - State
    @State private var shouldNavigate = false
    @State private var credentialAlert = false

    // MARK: - Body
    var body: some View {
        VStack {
            ActivatedButton(buttonText: .signUpText) {
                
                // MARK: - Form Validation Flags
                let isEmailSignup = formViewModal.signUpData.signUpWith == .withEmail
                let isPhoneSignup = formViewModal.signUpData.signUpWith == .withPhoneNumber
                
                let isEmailValid = formViewModal.isEmailValid(email: formViewModal.signUpData.signUpEmail)
                let isPasswordValid = formViewModal.isPasswordValid(password: formViewModal.signUpData.signUpPassword)
                let isPhoneValid = formViewModal.signUpData.phoneNumber.count == 10
                let isPasswordConfirmed = formViewModal.signUpData.confirmPassword == formViewModal.signUpData.signUpPassword
                let isGenderSelected = formViewModal.signUpData.selectedGender != nil
                
                if isEmailSignup {
                    if isEmailValid && isPasswordValid && isPasswordConfirmed && isGenderSelected {
                        Task {
                            do {
                                await firebaseValidation.register(
                                    withEmail: formViewModal.signUpData.signUpEmail,
                                    password: formViewModal.signUpData.signUpPassword,
                                    firstName: formViewModal.signUpData.firstName,
                                    lastName: formViewModal.signUpData.lastName,
                                    age: formViewModal.signUpData.ageValue,
                                    gender: formViewModal.signUpData.selectedGender?.rawValue ?? ""
                                )
                                let defaultImage = UIImage(systemName: "person.circle")!
                                await firebaseValidation.saveUserData(with: defaultImage)
                                shouldNavigate = true
                            }
                        }
                    } else {
                        credentialAlert = true
                    }
                }
                else if isPhoneSignup {
                    if isPhoneValid && isPasswordValid && isPasswordConfirmed && isGenderSelected {
                        Task {
                            do {
                                await firebaseValidation.register(
                                    withEmail: "Aryan@Gmail.com",
                                    password: formViewModal.signUpData.signUpPassword,
                                    firstName: formViewModal.signUpData.firstName,
                                    lastName: formViewModal.signUpData.lastName,
                                    age: formViewModal.signUpData.ageValue,
                                    gender: formViewModal.signUpData.selectedGender?.rawValue ?? "",
                                    phoneNumber: formViewModal.signUpData.phoneNumber
                                )
                                let defaultImage = UIImage(systemName: "person.circle")!
                                await firebaseValidation.saveUserData(with: defaultImage)
                                shouldNavigate = true
                            }
                        }
                    } else {
                        credentialAlert = true
                    }
                }
            }
        }
        .alert(isPresented: $credentialAlert,content: {
            Alert(title: Text("Alert:"),
                message: Text("press OK to execute default action..."),
                dismissButton: Alert.Button.default(
                    Text("Press ok here"), action: {
                        credentialAlert = false
                    }
                )
            )
        })


        .navigationDestination(isPresented: $shouldNavigate) {
            SuccessSplashView()
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        SignUpButton()
            .environmentObject(FormViewModal())
            .environmentObject(FirebaseValidation())
    }
}
