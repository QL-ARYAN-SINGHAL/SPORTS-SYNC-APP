//
//  ForgetPaswordTextField.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 16/04/25.
//

import SwiftUI

struct ForgetPaswordTextField: View {
    @State private var emailtext: String = ""
    var body: some View {
        VStack{
            
            FormTextfields(textField: $emailtext, placeholder: .emailPlaceholder)
             
        }
    }
}

#Preview {
    ForgetPaswordTextField()
}
