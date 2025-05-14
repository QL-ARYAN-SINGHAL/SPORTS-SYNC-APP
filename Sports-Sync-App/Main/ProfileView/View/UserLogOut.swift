//
//  UserLogOut.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 04/05/25.
//
import SwiftUI

struct UserLogOut: View {
    @State private var logOutNavigation: Bool = false
    let firebaseValidation = FirebaseValidation.firebaseInstance

    var body: some View {
        NavigationStack {
            VStack {
                ActivatedButton(
                    buttonText: .logOutString,
                    action: {
                        firebaseValidation.signOut()
                        logOutNavigation = true
                    })
            }
            .navigationDestination(isPresented: $logOutNavigation) {
                LandingScreen() // Navigate to LandingScreen after logout
            }
        }
    }
}

#Preview {
    UserLogOut()
        .environmentObject(FirebaseValidation())
}
