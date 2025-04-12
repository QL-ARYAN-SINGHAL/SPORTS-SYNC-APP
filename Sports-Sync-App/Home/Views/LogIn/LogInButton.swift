//
//  LogInButton.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 12/04/25.
//

import SwiftUI

struct LogInButton: View {
    var body: some View {
        VStack(alignment: .leading){
            
            //MARK: FORGOT PASSWORD BUTTON
            Button (action : {} , label: {
                Text(verbatim: .forgotPassword)
                    .font(.body)
                    .padding(.leading , 15)
            })
           
            //MARK: LOGIN BUTTON TO GET YOUR LOGGED IN
            
            ActivatedButton(buttonText: .logInText, action: {})
            
            
            
        }
        
    }
}

#Preview {
    LogInButton()
}
