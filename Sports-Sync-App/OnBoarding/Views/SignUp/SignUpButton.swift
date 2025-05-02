//
//  SignUpButton.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 13/04/25.
//

//
//  SignUpButton.swift
//  Sports-Sync-App
//  Created by ARYAN SINGHAL on 13/04/25.


//Sunday Program - Make the user 

import SwiftUI

struct SignUpButton: View {
    @EnvironmentObject var formViewModal: FormViewModal
    @EnvironmentObject var firebaseValidation : FirebaseValidation
    @State private var shouldNavigate = false

    var body: some View {
        ActivatedButton(buttonText: .signUpText) {
            
            //Conditions to validate your email and password are as per the regex
            let isEmailSignup = formViewModal.signUpData.signUpWith == .withEmail
            let isEmailValid = formViewModal.isEmailValid(email: formViewModal.signUpData.signUpEmail)
            let isPasswordValid = formViewModal.isPasswordValid(password: formViewModal.signUpData.signUpPassword)
            let isPhoneValid = formViewModal.signUpData.phoneNumber.count == 10
            let isPhoneSignup = formViewModal.signUpData.signUpWith == .withPhoneNumber
           
            
        //if .withEmail is owkring
            if isEmailSignup{
                
                if isEmailValid && isPasswordValid {
                    if formViewModal.signUpData.confirmPassword == formViewModal.signUpData.signUpPassword && formViewModal.signUpData.selectedGender != nil {
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
                                //saves user data in userDefault
                              await  firebaseValidation.saveUserData()
                                shouldNavigate = true
                            }
                        }
                    } else {
                        shouldNavigate = false
                    }
                } else {
                    shouldNavigate = false
                }
                
               
            }
            //if isPhone working
            else if isPhoneSignup{
                
                if isPhoneValid && isPasswordValid {
                    if formViewModal.signUpData.confirmPassword == formViewModal.signUpData.signUpPassword && formViewModal.signUpData.selectedGender != nil {
                        print("Validation success for phone signup")
                        Task {
                            do {
                                 await firebaseValidation.register(
                                    withEmail: "Guest@gmail.com",
                                    password: formViewModal.signUpData.signUpPassword,
                                    firstName: formViewModal.signUpData.firstName,
                                    lastName: formViewModal.signUpData.lastName,
                                    age: formViewModal.signUpData.ageValue,
                                    gender: formViewModal.signUpData.selectedGender?.rawValue ?? "",
                                    phoneNumber: formViewModal.signUpData.phoneNumber
                                )
                                formViewModal.showAlert = false
                                shouldNavigate = true
                            }
                        }
                    } else {
                        shouldNavigate = false
                   }
                } else {
                    shouldNavigate = false
                }
            }
            }

        .alert(isPresented: $formViewModal.showAlert) {
            Alert(
                title: Text(verbatim: .signUpAlertTitle),
                message: Text(verbatim: .signUpAlertMessage),
                dismissButton: .default(Text("Okay"))
            )
        }

        NavigationLink(
            destination: SuccessSplashView(),
            isActive: $shouldNavigate,
            label: { EmptyView() }
        )
    }
}

#Preview {
    SignUpButton()
}
