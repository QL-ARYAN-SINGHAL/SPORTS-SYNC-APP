//
//  signUpGender.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 13/04/25.
//

import SwiftUI

struct SignUpGender: View {
    @State var selectedGender: Gender?

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(verbatim: .gender)
                .frame(width: UIScreen.main.bounds.width * 0.90, alignment: .leading)
                .bold()

            // MARK: GENDER TOGGLES LOGIC
            ForEach(Gender.allCases) { gender in
                HStack {
                    Text(gender.rawValue)
                    Spacer()
                    Toggle("", isOn: Binding(
                        get: {
                            selectedGender == gender
                        },
                        set: { isOn in
                            if isOn {
                                selectedGender = gender
                            } else {
                                selectedGender = nil
                            }
                        }
                    ))
                    .labelsHidden()
                }
            }
        }
        .tint(.primaryBlue)
        .padding(.top, 10)
        .padding(.horizontal)
    }
}

#Preview {
    SignUpGender()
}
