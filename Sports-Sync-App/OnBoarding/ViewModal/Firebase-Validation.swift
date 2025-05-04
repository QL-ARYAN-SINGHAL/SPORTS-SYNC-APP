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
    @Published var isAuthenticated: Bool = false
    @Published var verificationCode : String = ""
    @Published var storedUser: SignUpDataModel?
    
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task{
           await fetchUser()
        }
    }
    
    
    //function to signUp user through login page
    
    func signIn(withEmail email: String, withPassword password: String) async throws {
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
            isAuthenticated = true
        }
        catch{
            print("Error in signing in the user \(error.localizedDescription)")
            throw error
            
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
       
        }
    
    
//function to register user data in our database
    
    func register(withEmail email: String?, password: String, firstName: String, lastName: String, age: Double, gender: String, phoneNumber: String? = nil) async{
        do {
            let result = try await Auth.auth().createUser(withEmail: email!, password: password)
            self.userSession = result.user

            var user = SignUpDataModel(
                id: result.user.uid,
                signUpEmail: email ?? "aryan123" ,
                signUpPassword: password,
                firstName: firstName,
                lastName: lastName,
                selectedGender: Gender(rawValue: gender),
                ageValue: age,
                phoneNumber: phoneNumber ?? ""
            )
//conditions to identify what will be selected .withEmail or .withPhoneNumber
            if email?.contains("@") == true {
                user.signUpEmail = email ?? ""
                user.signUpWith = .withEmail
            } else if let phone = phoneNumber, phone.count == 10 {
                user.phoneNumber = phone
                user.signUpWith = .withPhoneNumber
            }

            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            print("Saving user to Firestore with ID: \(user.id)")

            await fetchUser()
            isAuthenticated = true
            print("Saving user to Firestore with ID: \(user.id)")

        } catch {
            print("Failed to create user: \(error.localizedDescription)")
        }
    }

    //function to reset password
    
    func resetPassword(email: String){
          Auth.auth().sendPasswordReset(withEmail: email){ error in
              if error != nil {
                  print("Reset Password error : \(error?.localizedDescription)")
                  return
              }
              print("success")
          }
      }
    
    
    //function to send otp on phone number
    func sendOTP(phoneNumber : String ){
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: "", verificationCode: "")
        Auth.auth().signIn(with: credential as! FederatedAuthProvider, uiDelegate: nil) { user, error in
            if let error = error {
                print("OTP error : \(error.localizedDescription)")
                return
            }
            print("success")
        }
    }
    
    //Saves user data in UserDefault
    func saveUserData() async {
        guard let currentUser = currentUser else {
            print("No current user to save in UserDefaults")
            return
        }

        UserDefaults.standard.set(currentUser.firstName, forKey: "FirstName")
        UserDefaults.standard.set(currentUser.lastName, forKey: "LastName")
        UserDefaults.standard.set(currentUser.ageValue, forKey: "AgeValue")

        if let gender = currentUser.selectedGender?.rawValue {
            UserDefaults.standard.set(gender, forKey: "SelectedGender")
        }

        UserDefaults.standard.set(currentUser.signUpEmail, forKey: "SignUpEmail")
        
        if !currentUser.phoneNumber.isEmpty {
            UserDefaults.standard.set(currentUser.phoneNumber, forKey: "PhoneNumber")
        }
    }

    
    func getUserData() -> SignUpDataModel {
        let firstName = UserDefaults.standard.string(forKey: "FirstName") ?? ""
        let lastName = UserDefaults.standard.string(forKey: "LastName") ?? ""
        let ageValue = UserDefaults.standard.double(forKey: "AgeValue")
        let genderRaw = UserDefaults.standard.string(forKey: "SelectedGender") ?? ""
        let email = UserDefaults.standard.string(forKey: "SignUpEmail") ?? ""
        print("getUser default data is --->\(firstName)")
        print("getUser default data is --->\(lastName)")
        print("getUser default data is --->\(ageValue)")
        print("getUser default data is --->\(genderRaw)")
        print("getUser default data is --->\(email)")

     return SignUpDataModel(
            signUpEmail: email,
            firstName: firstName,
            lastName: lastName,
            selectedGender: Gender(rawValue: genderRaw),
            ageValue: ageValue
        )
       
    }

    
    
    func loadStoredUserData() {
        storedUser = getUserData()
    }
}
