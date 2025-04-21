//
//  LogInButton.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 12/04/25.
//

import SwiftUI

struct LogInButton: View {
   
    @State private var shouldNavigate = false
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
                    Task {
                        do {
                            try await firebaseValidation.signIn(
                                withEmail: formViewModal.logInData.loginEmail,
                                withPassword: formViewModal.logInData.loginPassword
                            )
                            
                            // Check if user is now authenticated
                            if firebaseValidation.isAuthenticated {
                                shouldNavigate = true
                            } else {
                                formViewModal.showAlert = true
                            }
                        } catch {
                           print("Error found to match user credentials: \(error.localizedDescription)")
                            formViewModal.showAlert = true
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
                    destination: WelcomingScreen(),
                    isActive: $shouldNavigate,
                    label: { EmptyView() }
                )
            }
        }
    }
}


#Preview {
    LogInButton()
       
}
