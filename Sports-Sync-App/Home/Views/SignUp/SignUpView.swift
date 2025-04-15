//
//  SignU.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 12/04/25.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject private var signUpDataModal = SignUpDataModel()
    
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
        .environmentObject(signUpDataModal)
       
    }
        
}

#Preview {
    SignUpView()
}


