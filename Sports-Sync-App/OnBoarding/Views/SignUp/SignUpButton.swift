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

    // MARK: - Props
    @Binding var isLoading: Bool

    // MARK: - State
    @State private var shouldNavigate = false
    @State private var credentialAlert = false

    // MARK: - Body
    var body: some View {
        VStack {
            ActivatedButton(buttonText: isLoading ? "Signing Up..." : .signUpText, isDisabled: isLoading) {
                
                // MARK: - Form Validation Flags
                let isEmailSignup = formViewModal.signUpData.signUpWith == .withEmail
              

                let isEmailValid = formViewModal.isEmailValid(email: formViewModal.signUpData.signUpEmail)
                let isPasswordValid = formViewModal.isPasswordValid(password: formViewModal.signUpData.signUpPassword)
               
                let isPasswordConfirmed = formViewModal.signUpData.confirmPassword == formViewModal.signUpData.signUpPassword
                let isGenderSelected = formViewModal.signUpData.selectedGender != nil

                if isEmailSignup {
                    if isEmailValid && isPasswordValid && isPasswordConfirmed && isGenderSelected {
                        Task {
                            isLoading = true
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
                            isLoading = false
                        }
                    } else {
                        credentialAlert = true
                    }
                }
               
            }
        }
        .alert("Alert", isPresented: $credentialAlert) {
            Button("OK", role: .cancel) {
            }
        } message: {
            Text(verbatim: .signUpAlertMessage)
        }


        .navigationDestination(isPresented: $shouldNavigate) {
            SuccessSplashView()
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        SignUpButton(isLoading: .constant(false))
            .environmentObject(FormViewModal())
            .environmentObject(FirebaseValidation())
    }
}
