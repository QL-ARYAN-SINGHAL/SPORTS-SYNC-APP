//
//  ReusableSecureField.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 13/04/25.
//

import SwiftUI

struct ReusableSecureField: View {
    
    @Binding var text: String
    var placeholder: String
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isPasswordVisible {
                    TextField(placeholder, text: $text)
                } else {
                    SecureField(placeholder, text: $text)
                }
            }
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
            
            Button(action: {
                isPasswordVisible.toggle()
            }) {
                Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                    .foregroundColor(.black)
                    .padding(.trailing, 12)
            }
        }
    }
}

#Preview {
    
}
