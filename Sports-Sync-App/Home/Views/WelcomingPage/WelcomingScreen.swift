//
//  WelcomingScreen.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 11/04/25.
//

import SwiftUI


struct WelcomingScreen: View {
    var body: some View {
        ZStack {
            WelcomingImage()
            
            VStack {
                
                WelcomingText()
                
                ActivatedButton(buttonText: .continueText, action: {})
                    .padding(.top, 50)
            }
            .padding()
            .background(Color.white)
            .shadow(color : .white , radius: 100 ,y : -100)
            .frame(maxHeight: .infinity, alignment: .bottom)
            
        }
        
    }
}

#Preview {
    WelcomingScreen()
}

