//
//  OTPTimer.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 16/04/25.
//

import SwiftUI

struct OTPTimer: View {
    @State var timeRemaining = 24
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
            Text("\(.resetOTPString)\(timeRemaining)s")
                .font(Font.custom(.fontJakartaBold, size: 14))
                .onReceive(timer) { _ in
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    }
                }
                .frame(width:350 , alignment: .leading)
                .foregroundStyle(.shadowtext)
        }
    }
}
#Preview {
    OTPTimer()
}
