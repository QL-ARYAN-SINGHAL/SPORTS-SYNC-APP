//
//  Firebase-Validation.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 21/04/25.
//

import FirebaseAuth
import FirebaseFirestore
import SwiftUI
import FirebaseStorage

@MainActor
class FirebaseValidation: ObservableObject {
    @Published var signUpData = SignUpDataModel()
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: SignUpDataModel?
    @Published var isAuthenticated: Bool = false
    @Published var verificationCode: String = ""
    @Published var storedUser: SignUpDataModel?
    @Published var userData: SignUpDataModel? = nil
    
    var avatarImage: UIImage? = nil

    init() {
        self.userSession = Auth.auth().currentUser
        Task {
            await fetchUser()
        }
    }

    // Sign in function with email and password
    func signIn(withEmail email: String, withPassword password: String)
        async throws
    {
        do {
            let result = try await Auth.auth().signIn(
                withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
            isAuthenticated = true
        } catch {
            print("Error in signing in the user \(error.localizedDescription)")
            throw error
        }
    }

    // Sign out function
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("Failed to sign out user")
        }
    }

    // Fetch user details from Firestore
    func fetchUser() async {
        guard let uid = self.userSession?.uid else { return }
        guard
            let snapshot = try? await Firestore.firestore().collection("users")
                .document(uid).getDocument()
        else { return }
        self.currentUser = try? snapshot.data(as: SignUpDataModel.self)

        // Update on main thread
        DispatchQueue.main.async {
            self.loadStoredUserData()
        }
    }

    // Register function to create a new user
    func register(
        withEmail email: String?, password: String, firstName: String,
        lastName: String, age: Double, gender: String,
        phoneNumber: String? = nil
    ) async {
        do {
            let result = try await Auth.auth().createUser(
                withEmail: email!, password: password)
            self.userSession = result.user

            var user = SignUpDataModel(
                id: result.user.uid,
                signUpEmail: email ?? "aryan123",
                signUpPassword: password,
                firstName: firstName,
                lastName: lastName,
                selectedGender: Gender(rawValue: gender),
                ageValue: age,
                phoneNumber: phoneNumber ?? ""
            )
            // Set user sign up method based on email or phone number
            if email?.contains("@") == true {
                user.signUpEmail = email ?? ""
                user.signUpWith = .withEmail
            } else if let phone = phoneNumber, phone.count == 10 {
                user.phoneNumber = phone
                user.signUpWith = .withPhoneNumber
            }

            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(
                user.id
            ).setData(encodedUser)
            print("Saving user to Firestore with ID: \(user.id)")

            await fetchUser()
            isAuthenticated = true

        } catch {
            print("Failed to create user: \(error.localizedDescription)")
        }
    }

    func sendOTP(phoneNumber: String) {
          PhoneAuthProvider.provider().verifyPhoneNumber("+91\(phoneNumber)", uiDelegate: nil) { verificationID, error in
              if let error = error {
                  print("Failed to send OTP: \(error.localizedDescription)")
                  return
              }

              if let verificationID = verificationID {
                  print("OTP Sent. Verification ID: \(verificationID)")
                  // Store verification ID in UserDefaults (or a @Published variable)
                  UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
              }
          }
      }
    
    // Function to reset password
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                print(
                    "Reset Password error : \(String(describing: error?.localizedDescription))"
                )
                return
            }
            print("success")
        }
    }

    // Save user data to UserDefaults
    func saveUserData(with avatarImage: UIImage?) async {
        guard let currentUser = currentUser else {
            print("No current user to save in UserDefaults")
            return
        }
        DispatchQueue.main.async {
            UserDefaults.standard.set(currentUser.firstName, forKey: "FirstName")
            UserDefaults.standard.set(currentUser.lastName, forKey: "LastName")
            UserDefaults.standard.set(currentUser.ageValue, forKey: "AgeValue")
            UserDefaults.standard.set(currentUser.signUpEmail, forKey: "SignUpEmail")

            if let gender = currentUser.selectedGender?.rawValue {
                UserDefaults.standard.set(gender, forKey: "SelectedGender")
            }

            if !currentUser.phoneNumber.isEmpty {
                UserDefaults.standard.set(currentUser.phoneNumber, forKey: "PhoneNumber")
            }

            if let avatarImage = avatarImage,
               let imageData = avatarImage.jpegData(compressionQuality: 0.6) {
                self.avatarImage = avatarImage
                UserDefaults.standard.set(imageData, forKey: "UserImage")
                print("User image saved in UserDefaults with , \(imageData)")
            }
        }
    }


    // Load user data from UserDefaults
    func getUserData() -> SignUpDataModel {
        let firstName = UserDefaults.standard.string(forKey: "FirstName") ?? ""
        let lastName = UserDefaults.standard.string(forKey: "LastName") ?? ""
        let ageValue = UserDefaults.standard.double(forKey: "AgeValue")
        let genderRaw =
            UserDefaults.standard.string(forKey: "SelectedGender") ?? ""
        let email = UserDefaults.standard.string(forKey: "SignUpEmail") ?? ""
        let phoneNumber =
            UserDefaults.standard.string(forKey: "PhoneNumber") ?? ""

        if let imageData = UserDefaults.standard.data(forKey: "UserImage") {
            avatarImage = UIImage(data: imageData)
        }

        return SignUpDataModel(
            signUpEmail: email,
            firstName: firstName,
            lastName: lastName,
            selectedGender: Gender(rawValue: genderRaw),
            ageValue: ageValue,
            phoneNumber: phoneNumber
        )
    }

    func loadStoredUserData() {
        DispatchQueue.main.async {
            self.storedUser = self.getUserData()
        }
    }

    
    func uploadProfileImageAndSaveToFirestore(_ image: UIImage) async {
        guard let uid = userSession?.uid,
              let imageData = image.jpegData(compressionQuality: 0.6) else { return }

        let storageRef = Storage.storage().reference().child("profile_images/\(uid).jpg")

        do {
            let _ = try await storageRef.putDataAsync(imageData)
            let downloadURL = try await storageRef.downloadURL()
            print("Image uploaded successfully, URL: \(downloadURL)")

            // Save to Firestore
            try await Firestore.firestore().collection("users").document(uid).updateData([
                "profileImageURL": downloadURL.absoluteString
            ])

            // Save locally too
            UserDefaults.standard.set(imageData, forKey: "UserImage")
            self.avatarImage = image

            // Optional: update currentUser object
            self.currentUser?.profileImageURL = downloadURL.absoluteString

        } catch {
            print("Error uploading image: \(error.localizedDescription)")
        }
    }

}
