//
//  ProgressValueCalculator.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 14/04/25.
//

import SwiftUI

class ProgressValueCalculator: ObservableObject {
    
    @ObservedObject var signUpData = SignUpDataModel()
    @Published var progress: Int = 0
    
    func calculateProgress() -> Int {
        var newProgress = 0
        
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
        
        self.progress = newProgress
        return self.progress
    }
}
