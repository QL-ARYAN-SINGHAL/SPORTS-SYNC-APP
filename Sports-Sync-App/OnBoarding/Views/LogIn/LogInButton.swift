import SwiftUI

struct LogInButton: View {
    @Binding var isLoading: Bool
    @State private var shouldNavigate = false
    @State private var navigateToOTP = false
    @State private var navigateToForgotPassword = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    @EnvironmentObject var formViewModal: FormViewModal

    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {

                Text(verbatim: .forgotPassword)
                    .font(Font.custom(.fontJakarta, size: 12))
                    .padding(.leading, 18)
                    .foregroundStyle(.blueTint)
                    .onTapGesture {
                        navigateToForgotPassword = true
                    }

                ActivatedButton(buttonText: .logInText) {
                    switch formViewModal.logInData.loginWith {
                    case .withEmail:
                        Task {
                            isLoading = true
                            do {
                                try await FirebaseValidation.shared.signIn(
                                    withEmail: formViewModal.logInData
                                        .loginEmail,
                                    withPassword: formViewModal.logInData
                                        .loginPassword
                                )

                                if FirebaseValidation.shared.isAuthenticated {
                                    shouldNavigate = true

                                    let defaultImage = UIImage(
                                        systemName: "person.circle")!
                                    await FirebaseValidation.shared.saveUserData(
                                        with: defaultImage)

                                } else {
                                    alertMessage = .logInAlertMessage
                                    showAlert = true
                                }
                            } catch {
                                alertMessage = error.localizedDescription
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
            .navigationDestination(isPresented: $navigateToForgotPassword) {
                ForgetPasswordView()
            }
           
            .navigationBarBackButtonHidden(false)
        }
        
    }
}

// MARK: - Preview
#Preview {
    LogInButton(isLoading: .constant(true))
        .environmentObject(FormViewModal())
        
}
