//
//  ReusbaleLoaderView.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 06/05/25.
//

import SwiftUI

// MARK: - Reusable Loader View
struct LoaderView: View {
    var message: String // Optional message to display with the loader
    @Binding var isLoading: Bool // A binding to control the loading state
    
    var body: some View {
        ZStack {
            if isLoading {
                Color.black.opacity(0.4).edgesIgnoringSafeArea(.all) // Semi-transparent background
                VStack {
                    ProgressView() // Loading spinner
                        .progressViewStyle(CircularProgressViewStyle(tint: .white)) // White spinner
                        .scaleEffect(2) // Scale the spinner
                    if !message.isEmpty {
                        Text(message) // Message Text
                            .foregroundColor(.white)
                            .padding(.top, 10)
                    }
                }
                .background(Color.black.opacity(0.7)) // Background color for loader
                .cornerRadius(10)
                .frame(width: 200, height: 150)
            }
        }
    }
}
