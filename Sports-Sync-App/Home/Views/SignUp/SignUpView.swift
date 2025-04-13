//
//  SignU.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 12/04/25.
//

import SwiftUI

struct SignUpView: View {
    var body: some View {
        VStack(alignment: .leading,spacing: 10){
            Text(verbatim: .signUpText)
                .font(.title2)
                .fontWeight(.medium)
            
            Text(verbatim: .signUpHeadline)
                .font(.body)
                .foregroundColor(.black.opacity(0.8))
        }
        .frame(width: 300,alignment: .leading)
        .padding(.leading,-50	)
        
        VStack{
            SignUpFields()
            
            SignUpAge()
                .padding(.vertical)
            
            SignUpGender()
            
            SignUpButton()
        }
       
    }
}

#Preview {
    SignUpView()
}
