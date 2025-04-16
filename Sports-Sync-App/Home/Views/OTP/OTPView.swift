//
//  OTPView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 16/04/25.
//

import SwiftUI

struct OTPView: View {
    private var imageConstants = ImageConstants()
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack{
            OTPTitle()
             
            OTPNumberBlocks()
                .padding()
            
            OTPTimer()
            
            Spacer()
            OTPButton()
        }
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
    OTPView()
}
