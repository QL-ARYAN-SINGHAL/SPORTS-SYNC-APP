//
//  LogIn.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 12/04/25.
//
import SwiftUI

struct LogInView: View {
    
    // MARK: - StateObjects
    @StateObject var formViewModal = FormViewModal()
    @StateObject var firebaseValidation = FirebaseValidation()
    @Binding var isLoading: Bool
    
    // MARK: - Body
    var body: some View {
        ZStack {
            VStack {
                // MARK: - Login Input Fields
                LogInFields()
                    .padding()
                
                // MARK: - Login Button Handler
                LogInButton(isLoading: $isLoading)
            }
            //ANOTHER LOADER TO DISPLAY
//            if isLoading {
//                       Color.black.opacity(0.6)
//                           .ignoresSafeArea()
//                       
//                       ProgressView("Signing up...")
//                           .progressViewStyle(CircularProgressViewStyle(tint: .white))
//                           .foregroundColor(.white)
//                           .font(.headline)
//                   }
            
            if isLoading {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                
                ProgressView("Logging in...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .foregroundColor(.white)
                    .font(.headline)
            }
        }
        // MARK: - Dependency Injection via Environment Objects
        .environmentObject(formViewModal)
        .environmentObject(firebaseValidation)
    }
}

// MARK: - Preview
#Preview {
    LogInView(isLoading: .constant(true))
}
