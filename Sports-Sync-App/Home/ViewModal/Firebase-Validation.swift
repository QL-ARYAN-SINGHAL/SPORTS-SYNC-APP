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
        Task{
           await  fetchUser()
        }
    }
    
    
    
    
    
    //function to signUp user through login page
    
    func signIn(withEmail email: String, withPassword password: String) async throws {
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        }
        catch{
            print("Error in signing in the user \(error.localizedDescription)")
        }
    }
    
    
    
    //function to signout user
    func signOut(){
        do{
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            
            //we will add signout button later in the profile page
        }
        catch{
            print("Faile to sign out user   ")
        }
    }
   
    
    //function to fetch user details stored in the db
    func fetchUser() async {
        guard let uid = self.userSession?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else{return}
        self.currentUser = try? snapshot.data(as: SignUpDataModel.self)
        print("Current user is \(self.currentUser)")
        }
    
    
//function to register user data in our database
    
    func register(withEmail email: String, password: String,firstName: String, lastName: String, age: Double, gender: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            
            let user = SignUpDataModel(
                id: result.user.uid, signUpEmail: email,
                signUpPassword: password,
                firstName: firstName,
                lastName: lastName,
                selectedGender: Gender(rawValue: gender),
                ageValue: age
                
            )
            
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("Failed to create user: \(error.localizedDescription)")
        }
    }
    
    
    //function to reset password
    
    func resetPassword(by email: String) async {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
        } catch {
            print("Error in resetting password: \(error.localizedDescription)")
        }
    }
}
