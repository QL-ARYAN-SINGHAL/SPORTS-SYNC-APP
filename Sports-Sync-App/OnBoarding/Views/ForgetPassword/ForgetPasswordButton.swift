//
//  ForgetPasswordButton.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 16/04/25.
//

import SwiftUI

struct ForgetPasswordButton: View {
    @State private var showErrorAlert = false
    @State private var shouldNavigate = false
    @EnvironmentObject var formViewModal: FormViewModal

  
    
    var body: some View {
        NavigationStack {
            VStack {
                ActivatedButton(buttonText: .resetPasswordString) {
                    Task {
                        let success = await FirebaseValidation.shared.resetPassword(email: formViewModal.logInData.forgotEmailText)
                        if success {
                            shouldNavigate = true
                        } else {
                            showErrorAlert = true
                        }
                    }
                }
            }
            .alert("Email invalid or not registered", isPresented: $showErrorAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Try email again!")
            }
            .navigationDestination(isPresented: $shouldNavigate) {
                ResetPasswordSuccess()
            }
        }
    }
}

#Preview {
    ForgetPasswordButton()
        .environmentObject(FormViewModal())
       
}

