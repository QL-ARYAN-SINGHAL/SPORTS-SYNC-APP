//
//  Firebase-Validation.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 21/04/25.
//

//
//  Firebase-Validation.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 21/04/25.
//

//
//  Firebase-Validation.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 21/04/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

@MainActor
class FirebaseValidation: ObservableObject {
    
   
    @Published var signUpData = SignUpDataModel()
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: SignUpDataModel?
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func signUp(withEmail email: String, withPassword password: String) async throws {
        // Optional: implement or remove if unused
    }
    
    func fetchUser() async {
        guard let uid = self.userSession?.uid else { return }
    }
    
    
    func register(withEmail email: String, password: String,firstName: String, lastName: String, age: Double, gender: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            
            let user = SignUpDataModel(
                signUpEmail: email,
                signUpPassword: password,
                firstName: firstName,
                lastName: lastName,
                selectedGender: Gender(rawValue: gender),
                ageValue: age
                
            )
            
            let encodedUser = try Firestore.Encoder().encode(user)
            
            if let uid = self.userSession?.uid {
                try await Firestore.firestore()
                    .collection("users")
                    .document(uid)
                    .setData(encodedUser)
            }
            
        } catch {
            print("Failed to create user: \(error.localizedDescription)")
        }
    }
    
    func resetPassword(by email: String) async {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
        } catch {
            print("Error in resetting password: \(error.localizedDescription)")
        }
    }
}
