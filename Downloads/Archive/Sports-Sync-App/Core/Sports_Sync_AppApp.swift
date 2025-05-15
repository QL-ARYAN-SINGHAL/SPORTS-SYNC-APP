//
//  Sports_Sync_AppApp.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 11/04/25.
//

import FirebaseAppCheck
import FirebaseAuth
import FirebaseCore
import FirebaseMessaging
import SwiftUI
import UserNotifications

@main
struct Sports_Sync_AppApp: App {
    

    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {

        WindowGroup {
            // use app storage / user defaults
            
            if !FirebaseValidation.shared.isAuthenticated {
                LandingScreen()
            } else {
                MainTabView()
            }

        }

    }
}
