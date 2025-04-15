//
//  LogIn.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 12/04/25.
//

import SwiftUI

struct LogInView: View {
    @StateObject private var loginDataModel = LoginDataModal()
    var body: some View {
        VStack{
            
            LogInFields()
                .padding()
            LogInButton()
        }
        .environmentObject(loginDataModel)
    }
        
}

#Preview {
    LogInView()
}
