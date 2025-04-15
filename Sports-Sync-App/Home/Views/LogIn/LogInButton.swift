//
//  LogInButton.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 12/04/25.
//

import SwiftUI

struct LogInButton: View {
    @ObservedObject var logInValidation = LoginValidation()
    @State private var shouldNavigate = false
    @EnvironmentObject var logInData: LoginDataModal

    var body: some View {
        VStack(alignment: .leading) {
            
            // MARK: FORGOT PASSWORD BUTTON
            
            Button(action: {}, label: {
                Text(verbatim: .forgotPassword)
                    .font(Font.custom(.fontJakarta, size: 12))
                    .padding(.leading, 15)
            })
            
            // MARK: Button to validate and navigate
            
            ActivatedButton(buttonText: .logInText, action: {
                
                // Validate email and password
                
                let isValidEmail = logInValidation.isEmailValid(email: logInData.loginEmail)
                let isValidPassword = logInValidation.isPasswordValid(password: logInData.loginPassword)
                
                
                if isValidEmail && isValidPassword {
                    self.shouldNavigate = true
                } 
            })
            .alert(isPresented: $logInValidation.showAlert) {
                Alert(
                    title: Text(verbatim: .logInAlertTitle),
                    message: Text(verbatim: .logInAlertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            
            NavigationLink(
                destination: WelcomingScreen(),
                isActive: $shouldNavigate,
                label: { EmptyView() }
            )
            
        }
    }
}

#Preview {
    LogInButton()
        .environmentObject(LoginDataModal())
}
