//
//  SignUpProgressBar.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 14/04/25.
//

import SwiftUI

struct SignUpProgressBar: View {
    
  
    @EnvironmentObject var formViewModal: FormViewModal
    
    var body: some View {
        
        VStack{
            
            Text(verbatim: .signUpProgressText)
                .font(Font.custom(.fontJakarta, size: 12))
                .frame(width: UIScreen.main.bounds.width*0.9, alignment: .leading)
                .foregroundStyle(.black.opacity(0.7))
            
            
            HStack{
                
                Text("\(formViewModal.calculateProgress(from: formViewModal.signUpData))%")
                    .bold()
                ProgressView(value: Double(Int(formViewModal.calculateProgress(from: formViewModal.signUpData))), total: 100)
                    .tint(.appTint)
                    .cornerRadius(12)
                    .scaleEffect(x: 1, y: 2.2, anchor: .center)
          
            }
            .frame(width: UIScreen.main.bounds.width*0.9)
            .padding(.leading,-5)
            
        }
        
        .padding(.horizontal,20)
        
    }
}


