//
//  SegmentController.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 12/04/25.
//

import SwiftUI

struct SegmentController: View {
    @State private var currentView: Int = 0

    var body: some View {
        VStack {
            Picker("Currently on", selection: $currentView) {
                
                    Text(verbatim: .logInText).tag(0)
                
                    Text(verbatim: .signUpText).tag(1)
                
             
            }
            .pickerStyle(.segmented)
            .tint(.primaryBlue)
            .padding(.horizontal, 20)
            
            
             
        }
        .frame(width: UIScreen.main.bounds.width*0.5)
        .navigationBarBackButtonHidden()
        if currentView == 0{
            LogInView()
        }
        else{
            SignUpView()
        }
        Spacer()
    }
}

#Preview {
    SegmentController()
}

