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


import SwiftUI

struct SignUpButton: View {
    @EnvironmentObject var formViewModal: FormViewModal
    @EnvironmentObject var firebaseValidation : FirebaseValidation
    @State private var shouldNavigate = false
 

    var body: some View {
        ActivatedButton(buttonText: .signUpText) {
            
            // MARK: SignUp email validation
            
            let isValid = formViewModal.isEmailValid(email: formViewModal.signUpData.signUpEmail)
            
            // MARK: SignUp Password validation
            
            let isPasswordValid = formViewModal.isPasswordValid(password: formViewModal.signUpData.signUpPassword)
            
            // MARK: SignUp Gender & Confirm password validation
            
            if isValid && isPasswordValid {
                if formViewModal.signUpData.confirmPassword == formViewModal.signUpData.signUpPassword && formViewModal.signUpData.selectedGender != nil {
                 
                    Task{
                        //Trigger user registration in firebase
                        try await firebaseValidation.register(
                            withEmail : formViewModal.signUpData.signUpEmail,
                            password :formViewModal.signUpData.signUpPassword,
                            firstName : formViewModal.signUpData.firstName,
                            lastName : formViewModal.signUpData.lastName,
                            age : formViewModal.signUpData.ageValue ,
                            gender :formViewModal.signUpData.selectedGender?.rawValue ?? "")
                    }
                    shouldNavigate = true
                } else {
                    shouldNavigate = false
                }
            } else {
                shouldNavigate = false
            }
        }
       
        
        
        .alert(isPresented: $formViewModal.showAlert) {
            Alert(
                title: Text(verbatim: .signUpAlertTitle),
                message: Text(verbatim: .signUpAlertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        
        NavigationLink(
            destination: WelcomingScreen(),
            isActive: $shouldNavigate,
            label: { EmptyView() }
        )
    }
}

#Preview {
    SignUpButton()
      
}
