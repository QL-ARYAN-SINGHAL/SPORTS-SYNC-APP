//
//  LogInButton.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 12/04/25.
//

import SwiftUI

struct LogInButton: View {
   
    //MARK: ENVIRONMENT OBJECT THAT USES BUILDER LOGIC TO VALIDATE OUR EMAIL AND PASSWORD
    
    @State private var shouldNavigate = false
    @EnvironmentObject var formViewModal : FormViewModal
    @EnvironmentObject var firebaseValidation : FirebaseValidation
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading) {
                
                // MARK: FORGOT PASSWORD NAVIGATION
                NavigationLink(destination: ForgetPasswordView()
                    .environmentObject(firebaseValidation), label:{
                    Text(verbatim: .forgotPassword)
                        .font(Font.custom(.fontJakarta, size: 12))
                        .padding(.leading, 18)
                        .foregroundStyle(.blueTint)
                }
                )
                
                // MARK: Button to validate and navigate
                
                ActivatedButton(buttonText: .logInText, action: {
                    
                    // Validate email and password
                    
                    let isValidEmail = formViewModal.isEmailValid(email:formViewModal.logInData.loginEmail)
                    print("email is -> \(formViewModal.logInData.loginEmail)")
                    let isValidPassword = formViewModal.isPasswordValid(password: formViewModal.logInData.loginPassword)
                    
                    
                    if isValidEmail && isValidPassword {
                        
                        
                        // Trigger user registration in firebase
                        Task{
                            try await firebaseValidation.signIn(withEmail: formViewModal.logInData.loginEmail, withPassword: formViewModal.logInData.loginPassword)
                                self.shouldNavigate = true
                            
                        }
                       
                    }
                })
                
                .alert(isPresented: $formViewModal.showAlert) {
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
}

#Preview {
    LogInButton()
       
}
