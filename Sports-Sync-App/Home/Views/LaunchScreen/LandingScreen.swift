//
//  ContentView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 11/04/25.
//

import SwiftUI

struct LandingScreen: View {
    
    //MARK: STATES
    @State private var offsetAnimation: CGFloat = UIScreen.main.bounds.width
    @State private var showSplash = true
    
    //MARK: INSTANCES OF FILES
    private var imageConstants = ImageConstants()
    
    var body: some View {
        VStack {
            if showSplash {
                VStack {
                    imageConstants.appImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .offset(x: offsetAnimation)
                        .animation(
                            .interpolatingSpring(stiffness: 100, damping: 10),
                            value: offsetAnimation
                        )
                }
                .onAppear {
                    offsetAnimation = 0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        showSplash = false
                    }
                }
            } else {
                WelcomingScreen()
            }
        }
    }
}

#Preview {
    LandingScreen()
}
