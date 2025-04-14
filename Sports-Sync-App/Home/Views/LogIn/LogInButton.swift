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
    var logInData = LoginDataModal()
    
    var body: some View {
        VStack(alignment: .leading) {
            
            // MARK: FORGOT PASSWORD BUTTON
            Button(action: {}, label: {
                Text(verbatim: .forgotPassword)
                    .font(Font.custom(.fontJakarta, size: 12))
                    .padding(.leading, 15)
            })
            
            // MARK: LOGIN BUTTON TO GET YOU LOGGED IN
            ActivatedButton(buttonText: .logInText, action: {
                let isValid = logInValidation.isEmailValid(email: logInData.loginEmail)
                let isPasswordValid = logInValidation.isPasswordValid(password: logInData.loginPassword)
                
                if isValid && isPasswordValid {
                    self.shouldNavigate = true
                }
            })
            
          
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
}
