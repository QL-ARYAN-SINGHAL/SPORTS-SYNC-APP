//
//  SignUpDataModal.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 14/04/25.
//
import SwiftUI

struct SignUpDataModel:Codable{
    
     var id: String = UUID().uuidString
     var signUpEmail: String?
     var signUpPassword: String?
     var confirmPassword: String?
     var firstName: String?
     var lastName: String?
     var selectedGender: Gender?
     var ageValue: Double?
     var ageLabel: String? {
         guard let age = ageValue else {
                 return "Age: 0"
             }
             return "Age: \(Int(age))"
    }
    var phoneNumber:String?
     var progress: Int?
    var signUpWith : LoginWith = .withEmail
    var profileImageURL: String?

    
}


