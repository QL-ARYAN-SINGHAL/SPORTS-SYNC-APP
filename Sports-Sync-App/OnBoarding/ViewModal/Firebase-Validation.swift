import FirebaseAuth
import FirebaseFirestore
import SwiftUI
import FirebaseStorage

@MainActor
class FirebaseValidation: ObservableObject {
    
    // MARK: - Published Properties
    @Published var signUpData = SignUpDataModel()
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: SignUpDataModel?
    @Published var isAuthenticated: Bool = false
    @Published var verificationCode: String = ""
    @Published var storedUser: SignUpDataModel?
    @Published var userData: SignUpDataModel? = nil

    // MARK: - Avatar Image
    var avatarImage: UIImage? = nil

    // MARK: - Initializer
    init() {
        // Check if user is already authenticated and set user session
        if let user = Auth.auth().currentUser {
            self.userSession = user
            self.isAuthenticated = true
            Task {
                await fetchUser()
            }
        } else {
            self.isAuthenticated = false
        }
    }

    // MARK: - Authentication Methods

    /// Signs in a user using email and password
    func signIn(withEmail email: String, withPassword password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
            isAuthenticated = true
        } catch {
            print("Error in signing in the user: \(error.localizedDescription)")
            throw error
        }
    }

    /// Signs out the current user
    func signOut() {
        do {
            // Sign out from Firebase
            
            
            // Clear UserDefaults data
            UserDefaults.standard.removeObject(forKey: "FirstName")
            UserDefaults.standard.removeObject(forKey: "LastName")
            UserDefaults.standard.removeObject(forKey: "AgeValue")
            UserDefaults.standard.removeObject(forKey: "SignUpEmail")
            UserDefaults.standard.removeObject(forKey: "SelectedGender")
            UserDefaults.standard.removeObject(forKey: "PhoneNumber")
         
            
            // Reset session and current user data
            self.userSession = nil
            self.currentUser = nil
            self.isAuthenticated = false
            try Auth.auth().signOut()
            
        } catch {
            print("Failed to sign out user")
        }
    }


    /// Sends an OTP to the given phone number
    func sendOTP(phoneNumber: String) {
        PhoneAuthProvider.provider().verifyPhoneNumber("+91\(phoneNumber)", uiDelegate: nil) { verificationID, error in
            if let error = error {
                print("Failed to send OTP: \(error.localizedDescription)")
                return
            }

            if let verificationID = verificationID {
                print("OTP Sent. Verification ID: \(verificationID)")
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            }
        }
    }

    /// Sends a password reset email
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Reset Password error: \(error.localizedDescription)")
                return
            }
            print("Password reset email sent successfully")
        }
    }

    // MARK: - Registration

    /// Registers a new user with given details
    func register(
        withEmail email: String?,
        password: String,
        firstName: String,
        lastName: String,
        age: Double,
        gender: String,
        phoneNumber: String? = nil
    ) async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email!, password: password)
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

        } catch {
            print("Failed to create user: \(error.localizedDescription)")
        }
    }

    // MARK: - Firestore User Handling

    /// Fetches user data from Firestore
    func fetchUser() async {
        guard let uid = self.userSession?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: SignUpDataModel.self)

        DispatchQueue.main.async {
            self.loadStoredUserData()
        }
    }

    /// Uploads profile image and updates Firestore
    func uploadProfileImageAndSaveToFirestore(_ image: UIImage) async {
        guard let uid = userSession?.uid,
              let imageData = image.jpegData(compressionQuality: 0.6) else { return }

        // Save image to app's local document directory
        let filename = "\(uid)_profile.jpg"
        let fileURL = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(filename)

        do {
            try imageData.write(to: fileURL)

            // Use fileURL.path as the local path string to store in Firestore
            try await Firestore.firestore().collection("users").document(uid).updateData([
                "profileImageURL": fileURL.path
            ])

            // Optionally cache for app use
            UserDefaults.standard.set(imageData, forKey: "UserImage")
            self.avatarImage = image
            self.currentUser?.profileImageURL = fileURL.path

            print("Image saved locally and path stored in Firestore: \(fileURL.path)")
        } catch {
            print("Error saving image locally: \(error.localizedDescription)")
        }
    }


    // MARK: - UserDefaults Handling

    /// Saves user data and avatar image to UserDefaults
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
                print("User image saved in UserDefaults, size: \(imageData.count) bytes")
            }
        }
    }

    /// Loads user data from UserDefaults into `storedUser`
    func loadStoredUserData() {
        DispatchQueue.main.async {
            self.storedUser = self.getUserData()
        }
    }

    /// Retrieves user data from UserDefaults
    func getUserData() -> SignUpDataModel {
        let firstName = UserDefaults.standard.string(forKey: "FirstName") ?? ""
        let lastName = UserDefaults.standard.string(forKey: "LastName") ?? ""
        let ageValue = UserDefaults.standard.double(forKey: "AgeValue")
        let genderRaw = UserDefaults.standard.string(forKey: "SelectedGender") ?? ""
        let email = UserDefaults.standard.string(forKey: "SignUpEmail") ?? ""
        let phoneNumber = UserDefaults.standard.string(forKey: "PhoneNumber") ?? ""

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
}
