//
//  ForgetPaswordTextField.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 16/04/25.
//

import SwiftUI

struct ForgetPaswordTextField: View {
    @EnvironmentObject var formViewModal: FormViewModal
    @EnvironmentObject var firebaseValidation : FirebaseValidation
    
    var body: some View {
        VStack{
            
            FormTextfields(textField: $formViewModal.logInData.forgotEmailText, placeholder: .emailPlaceholder)
             
        }
    }
}

#Preview {
    ForgetPaswordTextField()
}
