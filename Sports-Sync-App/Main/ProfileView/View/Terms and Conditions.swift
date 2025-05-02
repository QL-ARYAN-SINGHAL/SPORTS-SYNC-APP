//
//  Terms and Conditions.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 02/05/25.
//

import SwiftUI

struct TermsAndConditions: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                
                // Title
                Text(verbatim: .termsConditionString)
                    .font(Font.custom(.fontJakartaBold, size: 32))
                    .foregroundColor(.black)
                    .padding(.top, 20)
                    .padding(.horizontal)
                
                // Acceptance Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("1. Acceptance of Terms")
                        .font(Font.custom(.fontJakartaBold, size: 22))
                        .foregroundColor(.black)

                    Text("By using Sports Sync, you agree to comply with and be bound by these Terms & Conditions. If you do not agree, please do not use the app.")
                        .font(Font.custom(.fontJakarta, size: 15))
                        .foregroundColor(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal)
                
                // Usage Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("2. User Responsibilities")
                        .font(Font.custom(.fontJakartaBold, size: 22))
                        .foregroundColor(.black)

                    Text("You agree to use Sports Sync only for lawful purposes. You must not misuse the app by knowingly introducing malicious code or attempting unauthorized access.")
                        .font(Font.custom(.fontJakarta, size: 15))
                        .foregroundColor(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal)

                // Termination Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("3. Termination")
                        .font(Font.custom(.fontJakartaBold, size: 22))
                        .foregroundColor(.black)

                    Text("We reserve the right to suspend or terminate your access to Sports Sync at our discretion, without notice, if you violate these terms or engage in harmful behavior.")
                        .font(Font.custom(.fontJakarta, size: 15))
                        .foregroundColor(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding(.bottom, 40)
        }
        .background(Color.white)
    }
}

#Preview {
    TermsAndConditions()
}
