//
//  LoginEnums.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 22/04/25.
//
import Foundation

enum LoginWith: String,Identifiable,CaseIterable,Codable{
   
    case withEmail = " "
    case withPhoneNumber = ""
    
    var id: String { self.rawValue }
}
