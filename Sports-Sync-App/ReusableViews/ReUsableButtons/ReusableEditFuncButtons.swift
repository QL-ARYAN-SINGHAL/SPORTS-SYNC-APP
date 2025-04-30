//
//  ReusableFunctionalButtons.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 30/04/25.
//

import SwiftUI

struct ReusableEditFuncButtons: View {
    
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(Font.custom(.fontJakartaBold, size: 14))
                .frame(width: 74, height: 21)
                .foregroundStyle(.appTint)
                
        }
        .frame(width: 163, height: 48)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.appTint, lineWidth: 1)
        )
    }
}

#Preview {
    ReusableEditFuncButtons(text: "Edit plan", action: {})
}
