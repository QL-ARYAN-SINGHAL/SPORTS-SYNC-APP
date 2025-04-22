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
        VStack {
            ActivatedButton(buttonText: .resetPasswordString) {
                Task {
                    firebaseValidation.resetPassword(email: formViewModal.logInData.forgotEmailText) 
                }
            }

            NavigationLink(
                destination: ResetPasswordSuccess(),
                isActive: $shouldNavigate,
                label: { EmptyView() }
            )
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

#Preview {
    NavigationStack {
        ForgetPasswordButton()
            .environmentObject(FormViewModal())
            .environmentObject(FirebaseValidation())
    }
}
