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

    @Published var logInData = LoginDataModal()
    @Published var signUpData = SignUpDataModel()
    @Published var alertMessage: String?

    //MARK: BUILDER LOGIC FOR EMAIL VALIDATIOON , PASSWORD VALIDATION AND PROGRESS VIEW TRACKING
    func isEmailValid<T>(email: T) -> Bool {

        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,16}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)

        let isValid = emailTest.evaluate(with: email)

        return isValid
    }

    func isPasswordValid<T>(password: T) -> Bool {
        let passwordRegex = #"(?=^.{7,15}$)(?=^.*[A-Z].*$)(?=^.*\d.*$).*"#
        let passwordPredicate = NSPredicate(
            format: "SELF MATCHES %@", passwordRegex)
        let isPasswordValid = passwordPredicate.evaluate(with: password)

        return isPasswordValid
    }

    //function to make  a charcater limit
    func characterLimit(_ text: String, limit: Int) -> String {
        return String(text.prefix(limit))
    }

    ///Alert specific for validation
    func validateSignUpData() -> Bool {
        let data = signUpData

        if data.signUpEmail.trimmingCharacters(in: .whitespaces).isEmpty {
            alertMessage = "Email is required."
            return false
        }
        if !isEmailValid(email: data.signUpEmail) {
            alertMessage = "Email is invalid."
            return false
        }
        let nameCharacterSet = CharacterSet.letters.union(.whitespaces)

        if data.firstName.trimmingCharacters(in: .whitespaces).isEmpty {
            alertMessage = "First Name is required."
            return false
        }
        if data.firstName.rangeOfCharacter(from: nameCharacterSet.inverted)
            != nil
        {
            alertMessage = "First Name contains invalid characters."
            return false
        }
        if data.lastName.trimmingCharacters(in: .whitespaces).isEmpty {
            alertMessage = "Last Name is required."
            return false
        }
        if data.lastName.rangeOfCharacter(from: nameCharacterSet.inverted)
            != nil
        {
            alertMessage = "Last Name contains invalid characters."
            return false
        }
        if data.signUpPassword.isEmpty {
            alertMessage = "Password is required."
            return false
        }
        if !isPasswordValid(password: data.signUpPassword) {
            alertMessage =
                "Password must be 7–15 characters, include 1 uppercase & 1 number."
            return false
        }
        if data.signUpPassword != data.confirmPassword {
            alertMessage = "Passwords do not match."
            return false
        }
        if data.ageValue == 0 {
            alertMessage = "Age cannot be 0"
            return false
        }
        if data.selectedGender == nil {
            alertMessage = "Please select a gender."
            return false
        }

        alertMessage = nil
        return true
    }

    ///function to calculate progress
    func calculateProgress(from signUpData: SignUpDataModel) -> Int {
        var newProgress = 0
        DispatchQueue.main.async {

            if !signUpData.firstName.isEmpty {
                newProgress += 17
            }
            if !signUpData.lastName.isEmpty {
                newProgress += 17
            }
            if !signUpData.signUpEmail.isEmpty {
                newProgress += 17
            }
            if !signUpData.signUpPassword.isEmpty
                && !signUpData.confirmPassword.isEmpty
            {
                newProgress += 17
            }
            if signUpData.selectedGender != nil {
                newProgress += 17
            }
            if signUpData.ageValue != 0 {
                newProgress += 15
                if signUpData.ageValue == 0 {
                    newProgress -= 15
                }
            }

            self.signUpData.progress = newProgress

        }
        return signUpData.progress
    }

}
