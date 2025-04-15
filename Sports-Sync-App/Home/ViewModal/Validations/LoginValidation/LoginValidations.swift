//
//  LoginValidations.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 14/04/25.
//
import Foundation
import SwiftUI

class LoginValidation: ObservableObject {
    @Published var logInData = LoginDataModal()
    @Published var showAlert = false
    @Published var signUpData = SignUpDataModel()

    func isEmailValid<T>(email: T) -> Bool {
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,16}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        let isValid = emailTest.evaluate(with: email)

        if !isValid {
            showAlert = true
        }

        return isValid
    }
    
    func isPasswordValid<T>(password : T) -> Bool {
        let passwordRegex = #"(?=^.{7,15}$)(?=^.*[A-Z].*$)(?=^.*\d.*$).*"#
            let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        let isPasswordValid =  passwordPredicate.evaluate(with: password)
        if !isPasswordValid{
            showAlert = true
        }
        return isPasswordValid
    }
    
 
}
