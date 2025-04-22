//
//  SignUpDataModal.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 14/04/25.
//
import SwiftUI

struct SignUpDataModel:Codable{
    
     var id: String = UUID().uuidString
     var signUpEmail: String = ""
     var signUpPassword: String = ""
     var confirmPassword: String = ""
     var firstName: String = ""
     var lastName: String = ""
     var selectedGender: Gender? = nil
     var ageValue: Double = 0
     var ageLabel: String {
        "Age: \(Int(ageValue))"
    }
    var phoneNumber:String = ""
     var progress: Int = 0
    var signUpWith : LoginWith = .withPhoneNumber
}


