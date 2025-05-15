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

                    // MARK: - Form Validation Flags
                    let isEmailSignup =
                        formViewModal.signUpData.signUpWith == .withEmail

                    if isEmailSignup {
                        if formViewModal.validateSignUpData() {

                            Task {
                                isLoading = true
                                await FirebaseValidation.firebaseInstance
                                    .register(
                                        withEmail: formViewModal.signUpData
                                            .signUpEmail,
                                        password: formViewModal.signUpData
                                            .signUpPassword,
                                        firstName: formViewModal.signUpData
                                            .firstName,
                                        lastName: formViewModal.signUpData
                                            .lastName,
                                        age: formViewModal.signUpData.ageValue,
                                        gender: formViewModal.signUpData
                                            .selectedGender?.rawValue ?? ""
                                    )
                                let defaultImage = UIImage(
                                    systemName: "person.circle")!
                                await FirebaseValidation.firebaseInstance
                                    .saveUserData(with: defaultImage)
                                shouldNavigate = true
                                isLoading = false
                            }
                        } else {
                            // Set the alert message if validation fails
                            alertMessage =
                                formViewModal.alertMessage
                                ?? "Please fill out all required fields."
                            credentialAlert = true
                        }
                    }
                }, isDisabled: isLoading)
        }
        .alert(isPresented: $credentialAlert) {
            Alert(
                title: Text("Alert"),
                message: Text(alertMessage),
                dismissButton: .default(Text("Okay")) {
                    credentialAlert = false
                }
            )
        }
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
