//
//  welcomingText.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 12/04/25.
//

import SwiftUI

struct WelcomingText: View {
    var body: some View {
        VStack {
            ReusableTexts(textString: .welcomeHeadline)
            
            Text(verbatim: .welcomeSubtitle)
                .frame(width: UIScreen.main.bounds.width, height: 10, alignment: .center)
        }
    }
}

#Preview {
    WelcomingText()
}
