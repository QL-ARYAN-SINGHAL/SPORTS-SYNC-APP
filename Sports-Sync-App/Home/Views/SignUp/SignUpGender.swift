//
//  signUpGender.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 13/04/25.
//

import SwiftUI

struct SignUpGender: View {
    @EnvironmentObject var formViewModal: FormViewModal

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
                            
                            formViewModal.signUpData.selectedGender == gender
                        },
                        set: {
                            isOn in
                            if isOn {
                                
                                formViewModal.signUpData.selectedGender = gender
                                
                                
                            } else {
                                
                                formViewModal.signUpData.selectedGender = nil
                                
                            }
                            
                        }
                  
                    )
                    )
                    
                    .labelsHidden()
                }
            }
        }
        
        
        .tint(.appTint)
        .padding(.top, 10)
        .padding(.horizontal, 28)
    }
}

#Preview {
    SignUpGender()
        
}


