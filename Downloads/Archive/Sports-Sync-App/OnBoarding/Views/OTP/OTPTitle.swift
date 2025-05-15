//
//  OTPText.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 16/04/25.
//

import SwiftUI

struct OTPTitle: View {
 
    var body: some View {
        VStack{
            VStack(alignment: .leading,spacing: 10){
                Text(verbatim: .OTPTitle)
                    .font(Font.custom(.fontJakartaBold, size: 18))
                    .foregroundColor(.font)
                    
                
                Text("\(.OTPMessage) " )
                    .font(Font.custom(.fontJakarta, size: 12))
                    .foregroundColor(.shadowtext)
                  
                    
            }
            .frame(width: 300,alignment: .leading)
            .padding(.leading,-50)
            
            
        }
    }
}

#Preview {
    OTPTitle()
       
}
