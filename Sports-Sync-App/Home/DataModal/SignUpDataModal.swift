//
//  SignUpDataModal.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 14/04/25.
//
import SwiftUI

class SignUpDataModel :ObservableObject{
    
    @Published var value: Int = 0
    @Published var signUpEmail: String = ""
    @Published var signUpPassword: String = ""
    @Published var confirmPassword: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var selectedGender: Gender? = nil
    @Published var ageValue: Double = 0
    var ageLabel: String {
        "Age: \(Int(ageValue))"
    }
    @Published var progress: Int = 0
    
}
