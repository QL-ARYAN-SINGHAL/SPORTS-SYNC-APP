//
//  LogInButton.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 12/04/25.
//

import SwiftUI

struct LogInButton: View {
   
    @State private var shouldNavigate = false
    @State private var navigateToOTP = false
    @EnvironmentObject var formViewModal: FormViewModal
    @EnvironmentObject var firebaseValidation: FirebaseValidation
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                
                // Forgot Password Navigation
                NavigationLink(destination: ForgetPasswordView()
                    .environmentObject(firebaseValidation)) {
                    Text(verbatim: .forgotPassword)
                        .font(Font.custom(.fontJakarta, size: 12))
                        .padding(.leading, 18)
                        .foregroundStyle(.blueTint)
                }

                // Login Button
                ActivatedButton(buttonText: .logInText) {
                    switch formViewModal.logInData.loginWith {
                    case .withEmail:
                        Task {
                            do {
                                try await firebaseValidation.signIn(
                                    withEmail: formViewModal.logInData.loginEmail,
                                    withPassword: formViewModal.logInData.loginPassword
                                )
                                shouldNavigate = firebaseValidation.isAuthenticated
                                if !shouldNavigate {
                                    formViewModal.showAlert = true
                                }
                            }
                            catch {
                                print("Login failed with email: \(error.localizedDescription)")
                                formViewModal.showAlert = true
                            }
                        }

                    case .withPhoneNumber:
                        Task {
                            do{
                               firebaseValidation.sendOTP(
                                    phoneNumber: formViewModal.logInData.phoneNumber
                                )
                                navigateToOTP = firebaseValidation.isAuthenticated
                                if !navigateToOTP {
                                    formViewModal.showAlert = true
                                }
                            }
                           
                        }
                    }
                }

                
                .alert(isPresented: $formViewModal.showAlert) {
                    Alert(
                        title: Text(verbatim: .logInAlertTitle),
                        message: Text(verbatim: .logInAlertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }

                // Navigation after login
                NavigationLink(
                    destination: SuccessSplashView(),
                    isActive: $shouldNavigate,
                    label: { EmptyView() }
                )
                NavigationLink(
                    destination: OTPView(),
                    isActive: $navigateToOTP,
                    label: { EmptyView() }
                )
            }
        }
    }
}


#Preview {
    LogInButton()
       
}
