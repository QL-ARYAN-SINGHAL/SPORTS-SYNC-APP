//
//  OTPNumberBlocks.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 16/04/25.
//

import SwiftUI

struct OTPNumberBlocks: View {
    @State private var otpNumber : String = ""
    
    //MARK: FOCUS STATE USED TO KEEP TRACK AND CONTROL PROGRAMMATICALY
    @FocusState private var isKeyboardFocused: Bool

    var body: some View {
        HStack(spacing: 17) {
            ForEach(0..<6, id: \.self) { index in
                OTPTextbox(index)
            }
        }
        .onTapGesture {
            isKeyboardFocused = true
        }
        .background(
            TextField("", text: $otpNumber)
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .focused($isKeyboardFocused)
                .frame(width: 0, height: 0)
                .opacity(0.01)
                .onChange(of: otpNumber) { newValue in
                    if newValue.count > 6 {
                        //limit of 6 character only
                        otpNumber = String(newValue.prefix(6))
                    }
                }
        )
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isKeyboardFocused = true
            }
        }
    }
//MARK: VIEW BUILDER CREATES A FUNCTIONS AS A VIEW TO BE USED IN A RESUABLE MANNER IN OTHER COMPLEX VIEWS
    @ViewBuilder
    func OTPTextbox(_ index : Int) -> some View {
        ZStack {
            if index < otpNumber.count {
                //charindex here calculates the position of the number in a string
                //offsetBy return distance betewen two index
                let charIndex = otpNumber.index(otpNumber.startIndex, offsetBy: index)
                //extracts character and conves to string
                let charToString = String(otpNumber[charIndex])
                Text(charToString)
                    .font(.title)
            } else {
                Text(" ")
            }
        }
        .frame(width: 45 , height: 45)
        .background {
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .stroke(.gray, lineWidth: 1)
        }
    }
}

#Preview {
    OTPNumberBlocks()
}
