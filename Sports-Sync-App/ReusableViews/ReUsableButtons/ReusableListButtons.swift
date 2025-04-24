//
//  ReusableListButtons.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 23/04/25.
//

import SwiftUI

struct ReusableListButtons: View {
    
    let buttonText: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(buttonText)
                .font(Font.custom(.fontJakarta, size: 14))
                .foregroundColor(.disabledFont)
                .frame(width: 82, height: 35)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.disabledFont, lineWidth: 1)
                )
        }
          
    }
}

#Preview {
    ReusableListButtons(buttonText: "Week 1", action: {})
}
