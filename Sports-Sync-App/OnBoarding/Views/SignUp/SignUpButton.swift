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
    @State private var showAlert = false

    // MARK: - Body
    var body: some View {
        ActivatedButton(buttonText: .signUpText) {
            
            // MARK: - Form Validation Flags
            ///2 to switch between user prefernce of login
            let isEmailSignup = formViewModal.signUpData.signUpWith == .withEmail
            let isPhoneSignup = formViewModal.signUpData.signUpWith == .withPhoneNumber

            ///To check the validity through regex matching
            let isEmailValid = formViewModal.isEmailValid(email: formViewModal.signUpData.signUpEmail)
            let isPasswordValid = formViewModal.isPasswordValid(password: formViewModal.signUpData.signUpPassword)
            
            //To check the phone number regex , must be equal to 10
            let isPhoneValid = formViewModal.signUpData.phoneNumber.count == 10
            let isPasswordConfirmed = formViewModal.signUpData.confirmPassword == formViewModal.signUpData.signUpPassword
            
            let isGenderSelected = formViewModal.signUpData.selectedGender != nil
            
            // MARK: - Email Sign Up Logic
            if isEmailSignup {
                if isEmailValid && isPasswordValid {
                    if isPasswordConfirmed && isGenderSelected {
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
                        shouldNavigate = false
                        showAlert = true
                    }
                } else {
                    shouldNavigate = false
                    showAlert = true
                }
            }

            // MARK: - Phone Number Sign Up Logic
            else if isPhoneSignup {
                if isPhoneValid && isPasswordValid {
                    if isPasswordConfirmed && isGenderSelected {
                        print("Validation success for phone signup")
                        Task {
                            do {
                                await firebaseValidation.register(
                                    withEmail: "Aryan@Gmail.com", // Placeholder
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
                        shouldNavigate = false
                        showAlert = true
                    }
                } else {
                    shouldNavigate = false
                    showAlert = true
                }
            }
        }

        // MARK: - Alert
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(verbatim: .signUpAlertTitle),
                message: Text(verbatim: .signUpAlertMessage),
                dismissButton: .default(Text("Okay"))
            )
        }

        // MARK: - Navigation
        navigationDestination(isPresented:$shouldNavigate){
            SuccessSplashView()
        }
    }
}

// MARK: - Preview
#Preview {
    SignUpButton()
        .environmentObject(FormViewModal())
        .environmentObject(FirebaseValidation())
}
