//
//  PrivacyPolicy.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 02/05/25.
//

//
//  PrivacyPolicy.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 02/05/25.
//

import SwiftUI

struct PrivacyPolicy: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                
                // Title
                Text(verbatim: .privacyPolicyString)
                    .font(Font.custom(.fontJakartaBold, size: 32))
                    .foregroundColor(.black)
                    .padding(.top, 20)
                    .padding(.horizontal)
                
                // Introduction Section
                VStack(alignment: .leading, spacing: 12) {
                    Text(verbatim: .introductionHeading)
                        .font(Font.custom(.fontJakartaBold, size: 22))
                        .foregroundColor(.black)

                    Text(verbatim: .introductionMessageString)
                        .font(Font.custom(.fontJakarta, size: 15))
                        .foregroundColor(.black.opacity(0.7))
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal)
                
                // Information We Collect Section
                VStack(alignment: .leading, spacing: 12) {
                    Text(verbatim: .informationWeCollectString)
                        .font(Font.custom(.fontJakartaBold, size: 22))
                        .foregroundColor(.black)

                    Text(verbatim: .informationWeCollectMessageString)
                        .font(Font.custom(.fontJakarta, size: 15))
                        .foregroundColor(.black.opacity(0.7))
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
    PrivacyPolicy()
}
