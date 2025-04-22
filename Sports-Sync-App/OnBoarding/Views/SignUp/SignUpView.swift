//
//  SignU.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 12/04/25.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var formViewModal = FormViewModal()
    @StateObject var firebaseValidation = FirebaseValidation()
    var body: some View {
        
        ScrollView{
            VStack{
                SignUpHeading()
                
                SignUpFields()
                
                SignUpAge()
                
                
                SignUpGender()
                
                SignUpButton()
                
                
                Divider()
                
                SignUpProgressBar()
            }
            
          
            
        }
        .environmentObject(formViewModal)
        .environmentObject(firebaseValidation)
    }
}

#Preview {
    SignUpView()
}


