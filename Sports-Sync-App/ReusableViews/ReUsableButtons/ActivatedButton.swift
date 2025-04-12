//
//  ActivatedButton.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 12/04/25.
//

import SwiftUI

struct ActivatedButton: View {
    let buttonText: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(buttonText)
                .font(.system(size: 18))
                .foregroundColor(.white)
                .frame(width: 350, height: 60)
                .background(Color.primaryBlue)
                .cornerRadius(12)
        }
        .padding()
    }
}

#Preview {
    ActivatedButton(buttonText: "Continue") {
        print("Button tapped")
    }
}
