//
//  ForgetPasswordView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 16/04/25.
//

import SwiftUI

struct ForgetPasswordView: View {
    private var imageConstants = ImageConstants()
    @StateObject var formViewModal = FormViewModal()
    @StateObject var firebaseValidation = FirebaseValidation()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack{
            ForgetPasswordText()
                .padding()
            ForgetPaswordTextField()
            
            ForgetPasswordButton()
        }
        .environmentObject(formViewModal)
        .environmentObject(firebaseValidation)
      
        Spacer()
            .navigationBarCustombackButton(content:{
                Button(action : {dismiss() }, label: {
                    imageConstants.navigationBackImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50 , height: 30)
                        
                })
            })
    }
    
}

#Preview {
    ForgetPasswordView()
}
