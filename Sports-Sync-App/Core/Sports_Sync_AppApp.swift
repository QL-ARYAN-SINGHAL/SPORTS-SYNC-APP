//
//  Sports_Sync_AppApp.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 11/04/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseAppCheck
import FirebaseCore
import UserNotifications
import FirebaseMessaging

@main
struct Sports_Sync_AppApp: App {
    @StateObject var firebaseValidation = FirebaseValidation()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        
        
        WindowGroup {
            if !firebaseValidation.isAuthenticated{
                LandingScreen()
                    .environmentObject(firebaseValidation)
            }
            else{
                MainTabView()
            }
               
               
        }
        
        
       
    }
}
