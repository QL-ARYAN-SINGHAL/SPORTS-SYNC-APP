//
//  LogIn.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 12/04/25.
//

import SwiftUI

struct LogInView: View {
    
    var body: some View {
        VStack{
            LogInFields()
                .padding()
            LogInButton()
        }
       
    }
        
}

#Preview {
    LogInView()
}
