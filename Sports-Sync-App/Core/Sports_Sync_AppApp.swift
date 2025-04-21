//
//  Sports_Sync_AppApp.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 11/04/25.
//

import SwiftUI
import FirebaseAuth
import Firebase 

      

@main
struct Sports_Sync_AppApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            LandingScreen()
            
        }
    }
}
