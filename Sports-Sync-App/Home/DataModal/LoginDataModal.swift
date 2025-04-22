//
//  LoginDataModal.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 14/04/25.
//

import Foundation
struct LoginDataModal:Codable {
    //MARK: data modal for login
   
    var loginEmail:String = ""
    var loginPassword: String = ""
    var forgotEmailText: String = ""
    var phoneNumber:String = ""
    var loginWith : LoginWith = .withEmail
}
