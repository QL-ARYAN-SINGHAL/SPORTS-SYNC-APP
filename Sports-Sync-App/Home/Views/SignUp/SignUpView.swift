//
//  SignU.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 12/04/25.
//

import SwiftUI

struct SignUpView: View {
    var body: some View {
       
        VStack{
            SignUpHeading()
            
            SignUpFields()
            
            SignUpAge()
                .padding(.top,10)
            
            SignUpGender()
               
            SignUpButton()
                
            
            Divider()
            
            SignUpProgressBar()
        }
        .padding(.top,-13)
       
    }
}

#Preview {
    SignUpView()
}
