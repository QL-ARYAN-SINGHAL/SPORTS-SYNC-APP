//
//  LogIn.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 12/04/25.

import SwiftUI

/// MARK: - Parent View that holds state objects for form logic and Firebase validation.
/// It injects these as environment objects to its children views.

struct LogInView: View {
    
    // MARK: - StateObjects
    @StateObject var formViewModal = FormViewModal()
    @StateObject var firebaseValidation = FirebaseValidation()
    
    // MARK: - Body
    var body: some View {
        VStack {
            // MARK: - Login Input Fields
            LogInFields()
                .padding()
            
            // MARK: - Login Button Handler
            LogInButton()
        }
        // MARK: - Dependency Injection via Environment Objects
        .environmentObject(formViewModal)
        .environmentObject(firebaseValidation)
    }
}

// MARK: - Preview
#Preview {
    LogInView()
}
