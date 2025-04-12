//
//  LogInFields.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 12/04/25.
//

import SwiftUI

struct LogInFields: View {
   
    @State private var logInText: String = ""
    @State private var signUpText: String = ""
    
    var body: some View {
        VStack (spacing: 17){
         
            FormTextfields(textField: $logInText, placeholder: .emailPlaceholder)
            
            FormTextfields(textField: $signUpText, placeholder: .passwordPlaceholder)
        }
    }
}

#Preview {
    LogInFields()
}

