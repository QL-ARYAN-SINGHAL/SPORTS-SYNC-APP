//
//  WelcomingScreen.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 11/04/25.
//

import SwiftUI

struct WelcomingScreen: View {
    @State private var isActive = false
    @State private var isDisabling = false

    var body: some View {
        NavigationStack {
            ZStack {
                WelcomingImage()
                
                
                LinearGradient(
                    gradient: Gradient(colors: [Color.white.opacity(1), Color.white.opacity(1),
                        Color.white.opacity(0.3),
                        Color.white.opacity(0.2)]),
                    startPoint: .bottom,
                    endPoint: .top
                )
                .ignoresSafeArea()


                VStack {
                    WelcomingText()
                    

                    NavigationLink(destination: SegmentController(), isActive: $isActive) {
                        EmptyView()
                    }

                    ActivatedButton(buttonText: .continueText, action: {
                        isActive = true
                            
                    })
                    
                    .padding(.top, 50)
                    
                }
                
                .padding()
                
                .frame(maxHeight: .infinity, alignment: .bottom)
                
                
             
            }
           
        }
       
    }
}

#Preview {
    WelcomingScreen()
}
