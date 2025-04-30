//
//  ReusableShareFuncButton.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 30/04/25.
//

import SwiftUI

struct ReusableShareFuncButton: View {
    var text:String
    var action:()->Void
    var body: some View {
                Button(action: action) {
                    Text(text)
                        .font(Font.custom(.fontJakartaBold, size: 14))
                        .frame(width: 74, height: 21)
                        .foregroundStyle(.white)
                        
                }
                .frame(width: 163, height: 48)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(.appTint)
                )
            }
        }

#Preview {
    ReusableShareFuncButton(text: "Share", action: {})
}
