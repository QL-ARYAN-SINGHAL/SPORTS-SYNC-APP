//
//  SuccessSplashView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 16/04/25.
//

import SwiftUI

struct SuccessSplashView: View {
    private var imageConstants = ImageConstants()
    @State private var showSplash = true
    @State private var showText = false

    var body: some View {
        
        if showSplash{
            VStack(spacing: 20) {
                
                imageConstants.successImage
                    .frame(width: 92, height: 91)
                
               
                VStack(spacing: 10) {
                    Text(verbatim: .signUpSuccessString)
                        .font(Font.custom(.fontJakartaBold, size: 22))
                        .foregroundStyle(.font)
                        .fontWeight(.bold)
                        .padding(.top,40)
                    
                    
                    Text(verbatim: .signUpSuccessMessage)
                        .font(Font.custom(.fontJakarta, size: 14))
                        .foregroundColor(.shadowtext)
                        .multilineTextAlignment(.center)
                        .frame(width: 250)
                }
                
                .offset(y: showText ? 0 : 30)
                .animation(.easeOut(duration: 1.0).delay(0.8), value: showText)
            }
            .navigationBarBackButtonHidden()
            .padding(.top, 50)
            .onAppear {
                
                showText = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showSplash = false
                    }
                }
            }}
            
        else{
            MainTabView()
        }
    }
}

#Preview {
    SuccessSplashView()
}
