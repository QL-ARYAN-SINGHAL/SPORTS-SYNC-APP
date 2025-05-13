//
//  ForgetPasswordButton.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 16/04/25.
//

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
    @EnvironmentObject var firebaseValidation: FirebaseValidation

    var body: some View {
        NavigationStack{
            VStack {
                ActivatedButton(buttonText: .resetPasswordString) {
                    Task {
                        firebaseValidation.resetPassword(
                            email: formViewModal.logInData.forgotEmailText)
                    }
                }
                
                navigationDestination(isPresented: $shouldNavigate) {
                    ResetPasswordSuccess()
                }
            }
            .alert(isPresented: $showErrorAlert) {
                Alert(
                    title: Text("Email invalid or not registered"),
                    message: Text("Try email again!"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

#Preview {
    NavigationStack {
        ForgetPasswordButton()
            .environmentObject(FormViewModal())
            .environmentObject(FirebaseValidation())
    }
}
