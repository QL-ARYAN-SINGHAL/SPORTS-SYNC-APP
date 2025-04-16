//
//  ForgetPasswordButton.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 16/04/25.
//

import SwiftUI

struct ForgetPasswordButton: View {
    @State private var shouldNavigate = false
    var body: some View {
        NavigationStack{
            ActivatedButton(buttonText: .resetPasswordString, action: {shouldNavigate = true})
            
            NavigationLink(
                destination: OTPView(),
                isActive: $shouldNavigate,
                label: { EmptyView() }
            )
           
            
        }
    }
}

#Preview {
    ForgetPasswordButton()
}
