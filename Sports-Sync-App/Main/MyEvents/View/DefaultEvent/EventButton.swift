//
//  EventButton.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 23/04/25.
//


import SwiftUI

struct EventButton: View {
    @State private var makeNavigation: Bool = false
    
    var body: some View {
        Button(action: {
            makeNavigation = true
        }) {
            Text(verbatim: .createPlanString)
                .font(Font.custom(.fontJakartaBold, size: 12))
                .foregroundStyle(.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.appTint)
                )
        }
      
        .navigationDestination(isPresented: $makeNavigation) {
            SportSelection()
        }
    }
}

#Preview {
    NavigationStack {
        EventButton()
    }
}


