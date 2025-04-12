//
//  FormTextfields.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 12/04/25.
//

import SwiftUI

struct FormTextfields: View {
    @Binding var textField: String
    var placeholder: String
    
    var body: some View {
        TextField(placeholder, text: $textField)
            .padding(.horizontal)
            .padding(.vertical, 10)
            .frame(width: 360, height: 50)
            .accentColor(.black)
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 7)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1.5)
            )
    }
}

#Preview {
    FormTextfields(textField: .constant(""), placeholder: "Enter Username")
}
