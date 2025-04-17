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
    @State var isDisabled : Bool = false
    var body: some View {
        Button(action: action) {
            Text(buttonText)
                .font(.system(size: 18))
                .foregroundColor(isDisabled ? .disabledFont : Color.white)
                .frame(width: 360, height: 50)
                .background(isDisabled ? .disabledButton :  Color.appTint)
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
