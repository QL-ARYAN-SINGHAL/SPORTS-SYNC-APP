//
//  SignUpProgressBar.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 14/04/25.
//

import SwiftUI

struct SignUpProgressBar: View {
    
    @StateObject var progressValidation = ProgressValueCalculator()

    
    var body: some View {
        
        VStack{
            
            Text(verbatim: .signUpProgressText)
                .font(Font.custom(.fontJakarta, size: 12))
                .frame(width: 370, alignment: .leading)
                .foregroundStyle(.black.opacity(0.7))
            
            
            HStack{
                
                Text("\(progressValidation.progress)%")
                
                ProgressView(value: Double(Int(progressValidation.progress)), total: 100)
                    .tint(.appTint)
                    .cornerRadius(12)
                    .scaleEffect(x: 1, y: 2.2, anchor: .center)
          
            }
            
            .padding(.leading,-5)
            
        }
        
        .padding(.horizontal,20)
        
    }
}

#Preview {
    SignUpProgressBar()
}
