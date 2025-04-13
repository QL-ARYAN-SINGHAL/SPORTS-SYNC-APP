//
//  SignUpAge.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 13/04/25.
//

import SwiftUI

struct SignUpAge: View {
    @State private var value: Double = 0
    @State private var step: Double = 1
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text("Your Age: \(Int(value))")
                    .font(.subheadline)
                    .padding(.leading, 5)
            }
            
            //MARK: AGE SLIDER
            Slider(value: $value, in: 10...100, step: 1)
                .tint(.primaryBlue)
                .frame(width:300 )
        }
        .padding(.leading,-60)
       
    }
    }


#Preview {
    SignUpAge()
}
