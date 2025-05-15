import SwiftUI

struct SignUpButton: View {

    // MARK: - Environment Objects
    @EnvironmentObject var formViewModal: FormViewModal

    // MARK: - Props
    @Binding var isLoading: Bool

    // MARK: - State
    @State private var shouldNavigate = false
    @State private var credentialAlert = false
    @State private var alertMessage = ""

    // MARK: - Body
    var body: some View {
        VStack {
            ActivatedButton(
                buttonText: isLoading ? "Signing Up..." : .signUpText,
                action: {
                    let isEmailSignup = formViewModal.signUpData.signUpWith == .withEmail

                    if isEmailSignup {
                        if formViewModal.validateSignUpData() {
                            Task {
                                isLoading = true

                                guard let email = formViewModal.signUpData.signUpEmail,
                                      let password = formViewModal.signUpData.signUpPassword,
                                      let firstName = formViewModal.signUpData.firstName,
                                      let lastName = formViewModal.signUpData.lastName,
                                      let age = formViewModal.signUpData.ageValue,
                                      let gender = formViewModal.signUpData.selectedGender?.rawValue else {
                                    
                                    credentialAlert = true
                                    isLoading = false
                                    return
                                }

                                // Register user
                                await FirebaseValidation.shared.register(
                                    withEmail: email,
                                    password: password,
                                    firstName: firstName,
                                    lastName: lastName,
                                    age: age,
                                    gender: gender
                                )

                               
                                let defaultImage = UIImage(systemName: "person.circle")!
                                await FirebaseValidation.shared.saveUserData(with: defaultImage)

                               
                                shouldNavigate = true
                                isLoading = false
                            }
                        } else {
                            alertMessage = formViewModal.alertMessage ?? "Please fill out all required fields."
                            credentialAlert = true
                        }
                    }
                },
                isDisabled: isLoading
            )
        }
        .alert(alertMessage, isPresented: $credentialAlert) {}
        .navigationDestination(isPresented: $shouldNavigate) {
            SuccessSplashView()
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        SignUpButton(isLoading: .constant(false))
            .environmentObject(FormViewModal())
    }
}
