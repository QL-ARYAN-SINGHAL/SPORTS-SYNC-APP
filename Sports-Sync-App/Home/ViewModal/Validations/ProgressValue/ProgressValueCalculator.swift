//
//  ProgressValueCalculator.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 14/04/25.
//

import SwiftUI

class ProgressValueCalculator: ObservableObject {
    
    
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
            if signUpData.ageValue != 12 {
                newProgress += 15
            }
            
            signUpData.progress = newProgress
           
        }
        return signUpData.progress
        }
        
    }
    

