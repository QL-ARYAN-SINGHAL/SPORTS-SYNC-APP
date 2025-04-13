//
//  WelcomingScreen.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 11/04/25.
//

import SwiftUI

struct WelcomingScreen: View {
    @State private var isActive = false

    var body: some View {
        NavigationStack {
            ZStack {
                WelcomingImage()

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
                .background(Color.white)
                .shadow(color: .white, radius: 100, y: -100)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
           
        }
       
    }
}

#Preview {
    WelcomingScreen()
}
