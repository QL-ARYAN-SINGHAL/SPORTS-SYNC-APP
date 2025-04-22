//
//  ResetPasswordSuccess.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 21/04/25.
//

//
//  ResetPasswordSuccess.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 21/04/25.
//

//
//  ResetPasswordSuccess.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 21/04/25.
//

import SwiftUI

struct ResetPasswordSuccess: View {
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "envelope.badge")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.appTint)
                .padding()

            Text("Reset Link Sent!")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.primary)

            Text("We’ve sent a password reset link to your email. Please check your inbox and follow the instructions to reset your password.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

           
            NavigationLink(destination: SegmentController()) {
                Text("Back to Login")
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.appTint)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(radius: 2)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .background(Color(.systemGroupedBackground))
        .ignoresSafeArea(edges: .bottom)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationView {
        ResetPasswordSuccess()
    }
}
