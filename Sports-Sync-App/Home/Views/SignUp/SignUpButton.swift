//
//  SignUpButton.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 13/04/25.
//

//
//  SignUpButton.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 13/04/25.
//

import SwiftUI

struct SignUpButton: View {
    @ObservedObject var logInValidation = LoginValidation()
    @EnvironmentObject var signUpData: SignUpDataModel
    @State private var shouldNavigate = false
    var isDisabled: Bool {
        return signUpData.signUpEmail.isEmpty ||
        signUpData.signUpPassword.isEmpty ||
        signUpData.selectedGender == nil ||
        signUpData.confirmPassword.isEmpty
   }
   

    var body: some View {
        ActivatedButton(buttonText: .signUpText) {
            
            // MARK: SignUp email validation
            let isValid = logInValidation.isEmailValid(email: signUpData.signUpEmail)
            
            // MARK: SignUp Password validation
            let isPasswordValid = logInValidation.isPasswordValid(password: signUpData.signUpPassword)
            
            // MARK: SignUp Gender & Confirm password validation
            if isValid && isPasswordValid {
                if signUpData.confirmPassword == signUpData.signUpPassword && signUpData.selectedGender != nil {
                    shouldNavigate = true
                } else {
                    shouldNavigate = false
                }
            } else {
                shouldNavigate = false
            }
        }
       
        .background(isDisabled ? Color.gray : Color.appTint)
        .disabled(isDisabled)
        
        .alert(isPresented: $logInValidation.showAlert) {
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
        .environmentObject(SignUpDataModel())
}
