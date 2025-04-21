//
//  ForgetPasswordText.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 16/04/25.
//

import SwiftUI

struct ForgetPasswordText: View {
  
    var body: some View {
        VStack(alignment: .leading,spacing: 10){
            Text(verbatim: .forgotPasswordTitle)
                .font(Font.custom(.fontJakartaBold, size: 18))
                
                .fontWeight(.medium)
            
            Text(verbatim: .forgotPasswordMessage)
                .font(Font.custom(.fontJakarta, size: 12))
                .foregroundColor(.black.opacity(0.8))
                
        }
        .frame(width: 300,alignment: .leading)
        .padding(.leading,-50    )
    }
}

#Preview {
    ForgetPasswordText()
}
