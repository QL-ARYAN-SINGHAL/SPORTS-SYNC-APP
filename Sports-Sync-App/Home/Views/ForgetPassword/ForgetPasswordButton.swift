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
    @State private var shouldNavigate = false
    @EnvironmentObject var formViewModal: FormViewModal
    @EnvironmentObject var firebaseValidation: FirebaseValidation

    var body: some View {
        VStack {
            ActivatedButton(buttonText: .resetPasswordString) {
                Task {
                    await firebaseValidation.resetPassword(by: formViewModal.logInData.loginEmail)
                    shouldNavigate = true
                }
            }

            NavigationLink(
                destination: ResetPasswordSuccess(),
                isActive: $shouldNavigate,
                label: { EmptyView() }
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
