@preconcurrency import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import SwiftUI

@MainActor
class FirebaseValidation: ObservableObject{
    
    static let shared = FirebaseValidation()

    // MARK: - Published Properties
    @Published var signUpData = SignUpDataModel()
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: SignUpDataModel?
    @Published var isAuthenticated: Bool = false
    @Published var verificationCode: String = ""
    @Published var storedUser: SignUpDataModel?
    @Published var userData: SignUpDataModel? = nil

    // MARK: - Avatar Image
    @Published var avatarImage: UIImage? = nil

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
            print("Error in signing in the user: \(error.localizedDescription)")
            throw error
        }
    }

    /// Signs out the current user
    func signOut() {
        do {
          
            UserDefaults.standard.removeObject(forKey:.userDefaultEmail )
            UserDefaults.standard.removeObject(forKey:.userDefaultAgeValue)
            UserDefaults.standard.removeObject(forKey:.userDefaultLastName)
            UserDefaults.standard.removeObject(forKey: .userDefaultFirstName)
            UserDefaults.standard.removeObject(forKey:.userDefaultPhoneNumber)
            UserDefaults.standard.removeObject(forKey: .userDefaultSelectedGender)
        
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
        PhoneAuthProvider.provider().verifyPhoneNumber(
            "+91\(phoneNumber)", uiDelegate: nil
        ) { verificationID, error in
            if let error = error {
                print("Failed to send OTP: \(error.localizedDescription)")
                return
            }

            if let verificationID = verificationID {
                print("OTP Sent. Verification ID: \(verificationID)")
                UserDefaults.standard.set(
                    verificationID, forKey: "authVerificationID")
            }
        }
    }

    /// Sends a password reset email
    func resetPassword(email: String) async -> Bool {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
            return true
        } catch {
            return false
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
            let result = try await Auth.auth().createUser(
                withEmail: email!, password: password)
            self.userSession = result.user

            let user = SignUpDataModel(
                id: result.user.uid,
                signUpEmail: email ?? "aryan123",
                signUpPassword: password,
                firstName: firstName,
                lastName: lastName,
                selectedGender: Gender(rawValue: gender),
                ageValue: age,
                phoneNumber: phoneNumber ?? ""
            )

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

    // MARK: - Firestore User Handling

    /// Fetches user data from Firestore
    func fetchUser() async {
        guard let uid = self.userSession?.uid else { return }
        guard
            let snapshot = try? await Firestore.firestore().collection("users")
                .document(uid).getDocument()
        else { return }
        self.currentUser = try? snapshot.data(as: SignUpDataModel.self)

        DispatchQueue.main.async {
            self.loadStoredUserData()
        }
    }

    /// Uploads profile image and updates Firestore
    func uploadProfileImageAndSaveToFirestore(_ image: UIImage) async {
        guard let uid = userSession?.uid,
            let imageData = image.jpegData(compressionQuality: 0.4)
        else { return }

        // Save image to app's local document directory
        let filename = "\(uid)_profile.jpg"
        print(filename,"User image profile name ")
        //File manager is repsonoble to manage the files, document directory means the local path ofg the image , user domain mask means to check if they are in current user id
        let fileURL = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(filename)

        do {
            try imageData.write(to: fileURL)

            let base64String = imageData.base64EncodedString()

            try await Firestore.firestore().collection("users").document(uid)
                .updateData([
                    "profileImageURL": base64String
                ])

            UserDefaults.standard.set(imageData, forKey: .userDefaultUserImage)
            self.avatarImage = image
            self.currentUser?.profileImageURL = base64String

            
        } catch {
            print("Error saving image locally: \(error.localizedDescription)")
        }
    }

    // MARK: - UserDefaults Handling

    /// Saves user data and avatar image to UserDefaults
    func saveUserData(with avatarImage: UIImage?) async {
        guard let currentUser = currentUser else {
            return
        }

        DispatchQueue.main.async {
            UserDefaults.standard.set(
                currentUser.firstName, forKey: .userDefaultFirstName)
            UserDefaults.standard.set(currentUser.lastName, forKey: .userDefaultLastName)
            UserDefaults.standard.set(currentUser.ageValue, forKey: .userDefaultAgeValue)
            UserDefaults.standard.set(
                currentUser.signUpEmail, forKey: .userDefaultEmail)

            if let gender = currentUser.selectedGender?.rawValue {
                UserDefaults.standard.set(gender, forKey: .userDefaultSelectedGender)
            }

            if !currentUser.phoneNumber.isEmpty {
                UserDefaults.standard.set(
                    currentUser.phoneNumber, forKey: .userDefaultPhoneNumber)
            }

            if let avatarImage = avatarImage,
                let imageData = avatarImage.jpegData(compressionQuality: 0.5)
            {
                self.avatarImage = avatarImage
                UserDefaults.standard.set(imageData, forKey: .userDefaultUserImage)
               
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
        let firstName = UserDefaults.standard.string(forKey: .userDefaultFirstName) ?? ""
        let lastName = UserDefaults.standard.string(forKey: .userDefaultLastName) ?? ""
        let ageValue = UserDefaults.standard.double(forKey: .userDefaultAgeValue)
        let genderRaw =
        UserDefaults.standard.string(forKey: .userDefaultSelectedGender) ?? ""
        let email = UserDefaults.standard.string(forKey: .userDefaultEmail) ?? ""
        let phoneNumber =
        UserDefaults.standard.string(forKey: .userDefaultPhoneNumber) ?? ""

        if let imageData = UserDefaults.standard.data(forKey: .userDefaultUserImage) {
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
