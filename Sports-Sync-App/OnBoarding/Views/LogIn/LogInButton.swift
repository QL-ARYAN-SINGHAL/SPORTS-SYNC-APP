import SwiftUI

struct LogInButton: View {
    
    // MARK: - Binding
    @Binding var isLoading: Bool
    
    // MARK: - State
    @State private var shouldNavigate = false
    @State private var navigateToOTP = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    // MARK: - Environment Objects
    @EnvironmentObject var formViewModal: FormViewModal
    @EnvironmentObject var firebaseValidation: FirebaseValidation

    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                // MARK: - Forgot Password Navigation
                NavigationLink(destination: ForgetPasswordView()
                    .environmentObject(firebaseValidation)) {
                    Text(verbatim: .forgotPassword)
                        .font(Font.custom(.fontJakarta, size: 12))
                        .padding(.leading, 18)
                         .foregroundStyle(.blueTint)
                }
                
                // MARK: - Login Button
                ActivatedButton(buttonText: .logInText) {
                    isLoading = true
                    switch formViewModal.logInData.loginWith {
                        
                    case .withEmail:
                        Task {
                            do {
                                print("📧 Attempting login with email: \(formViewModal.logInData.loginEmail)")
                                try await firebaseValidation.signIn(
                                    withEmail: formViewModal.logInData.loginEmail,
                                    withPassword: formViewModal.logInData.loginPassword
                                )

                                if firebaseValidation.isAuthenticated {
                                    print("Email login successful.")
                                    shouldNavigate = true
                                    
                                    //this ensures the profile image is not overwritten
                                    let storedImageData = UserDefaults.standard.data(forKey: "UserImage")

                                    if let storedImageData,
                                       let userImage = UIImage(data: storedImageData) {
                                        await firebaseValidation.saveUserData(with: userImage)
                                    } else {
                                        let defaultImage = UIImage(systemName: "person.circle")!
                                        await firebaseValidation.saveUserData(with: defaultImage)
                                    }

                                } else {
                                    print("Email login failed - Auth flag is false.")
                                    alertMessage = .logInAlertMessage
                                    showAlert = true
                                }

                            } catch {
                                print("Email login error: \(error.localizedDescription)")
                                alertMessage = error.localizedDescription
                                showAlert = true
                            }
                            isLoading = false
                        }

                    case .withPhoneNumber:
                        Task {
                            print("📱 Sending OTP to phone: \(formViewModal.logInData.phoneNumber)")
                            firebaseValidation.sendOTP(phoneNumber: formViewModal.logInData.phoneNumber)

                            if firebaseValidation.isAuthenticated {
                                print("OTP sent successfully.")
                                navigateToOTP = true
                            } else {
                                print("OTP sending failed.")
                                alertMessage = "Failed to send OTP. Try again."
                                showAlert = true
                            }
                            isLoading = false
                        }
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(verbatim: .logInAlertTitle),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }

               
            }
            .navigationDestination(isPresented: $shouldNavigate) {
                MainTabView()
            }
            .navigationDestination(isPresented: $navigateToOTP) {
                OTPView()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    LogInButton(isLoading: .constant(false))
        .environmentObject(FormViewModal())
        .environmentObject(FirebaseValidation())
}
