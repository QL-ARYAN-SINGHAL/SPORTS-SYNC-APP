//
//  GenderEnums.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 13/04/25.
//

import Foundation

enum Gender: String, CaseIterable, Identifiable,Codable{
    case female = "Female"
    case male = "Male"
    case nonBinary = "Non-Binary"
    
    var id: String { self.rawValue }
}
