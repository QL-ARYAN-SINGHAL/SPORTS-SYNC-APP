//
//  SignUpAge.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 13/04/25.
//

import SwiftUI

struct SignUpAge: View {
    @EnvironmentObject var signUpData: SignUpDataModel
    @StateObject var progressValidation = ProgressValueCalculator()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            Text(signUpData.ageLabel)
                .font(Font.custom(.fontJakarta, size: 14))
                .padding(.leading, 5)
            
            Slider(value: $signUpData.ageValue, in: 10...100, step: 1)
                .tint(.appTint)
                .frame(width: 300)
              
        }
        .padding(.leading, -60)
    }
}

#Preview {
    SignUpAge()
        .environmentObject(SignUpDataModel())
}

