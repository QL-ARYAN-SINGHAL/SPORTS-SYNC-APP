//
//  UserSessionManager.swift
//  Sports-Sync-App
//
//  Created by 23187712V on 15/05/25.
//

import Foundation
import UIKit

class UserSessionManager {
    
    
    
    static func getUserProfileDetails() -> SignUpDataModel? {
        let firstName = UserDefaults.standard.string(forKey: .userDefaultFirstName)
        let lastName = UserDefaults.standard.string(forKey: .userDefaultLastName)
        let ageValue = UserDefaults.standard.double(forKey: .userDefaultAgeValue)
        let genderRaw =
        UserDefaults.standard.string(forKey: .userDefaultSelectedGender)
        let email = UserDefaults.standard.string(forKey: .userDefaultEmail)
        let phoneNumber =
        UserDefaults.standard.string(forKey: .userDefaultPhoneNumber)

        return SignUpDataModel(
            signUpEmail: email,
            firstName: firstName,
            lastName: lastName,
            selectedGender: Gender(rawValue: genderRaw ?? ""),
            ageValue: ageValue,
            phoneNumber: phoneNumber
        )
    }
    
    static func getUserProfileImage() -> UIImage? {
        guard let imageData = UserDefaults.standard.data(forKey: .userDefaultPhoneNumber) else { return nil }
        return UIImage(data: imageData)
    }
    
    
}
