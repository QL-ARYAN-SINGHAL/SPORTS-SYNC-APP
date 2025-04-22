//
//  formViewModal.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 14/04/25.
//
import Foundation
import SwiftUI


class FormViewModal: ObservableObject {
    //MARK: Published to keep track of the data modal inside view modal
    @Published var showAlert = false
    @Published var logInData = LoginDataModal()
    @Published var signUpData = SignUpDataModel()
   

    
    //MARK: BUILDER LOGIC FOR EMAIL VALIDATIOON , PASSWORD VALIDATION AND PROGRESS VIEW TRACKING
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
    
    
    
    func calculateProgress(from signUpData: SignUpDataModel)->Int {
        var newProgress = 0
        DispatchQueue.main.async{
            
            if !signUpData.firstName.isEmpty {
                newProgress += 17
            }
            if !signUpData.lastName.isEmpty {
                newProgress += 17
            }
            if !signUpData.signUpEmail.isEmpty {
                newProgress += 17
            }
            if !signUpData.signUpPassword.isEmpty && !signUpData.confirmPassword.isEmpty {
                newProgress += 17
            }
            if signUpData.selectedGender != nil {
                newProgress += 17
            }
            if signUpData.ageValue != 0 {
                newProgress += 15
            }
            
            self.signUpData.progress = newProgress
           
        }
        return signUpData.progress
        }
    
    
   
        
    
 
}
