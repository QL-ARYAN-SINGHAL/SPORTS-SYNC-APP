//
//  ReusableTexts.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 12/04/25.
//

import SwiftUI

struct ReusableTexts: View {
    var textString: String
    
    var body: some View {
        Text(textString)
            .font(Font.custom(.fontJakartaBold, size: 30))
            .frame(width: UIScreen.main.bounds.width, height: 100)
            .multilineTextAlignment(.center)
    }
}

#Preview {
    ReusableTexts(textString: "Hello, World!")  
}

