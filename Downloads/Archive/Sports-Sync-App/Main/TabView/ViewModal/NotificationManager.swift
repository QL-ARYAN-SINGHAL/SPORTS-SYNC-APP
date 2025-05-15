////
////  AppDelegate.swift
////  Sports-Sync-App
////
////  Created by ARYAN SINGHAL on 14/05/25.
////
//
//import SwiftUI
//import FirebaseCore
//import FirebaseAuth
//import FirebaseMessaging
//import FirebaseAppCheck
//import UserNotifications
//import UIKit
//
//class AppDelegate: NSObject, UIApplicationDelegate {
//    let gcmMessageIDKey = "gcm.message_id"
//    
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        // Firebase setup
//        FirebaseApp.configure()
//        Messaging.messaging().delegate = self
//        
//        // Notification permission request
//        if #available(iOS 10.0, *) {
//            UNUserNotificationCenter.current().delegate = self
//            
//            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//            UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, error in
//                if let error = error {
//                    print(" Notification authorization error: \(error.localizedDescription)")
//                } else {
//                    print(" Notification permission granted: \(granted)")
//                }
//
//                // Get current settings to debug
//                UNUserNotificationCenter.current().getNotificationSettings { settings in
//                    print(" Notification status: \(settings.authorizationStatus.rawValue)")
//                }
//
//                DispatchQueue.main.async {
//                    application.registerForRemoteNotifications()
//                }
//            }
//        } else {
//            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//            application.registerUserNotificationSettings(settings)
//        }
//        
//        return true
//    }
//
//    func application(_ application: UIApplication,
//                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
//                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        if let messageID = userInfo[gcmMessageIDKey] {
//            print(" Message ID: \(messageID)")
//        }
//        print(" Notification payload: \(userInfo)")
//        completionHandler(.newData)
//    }
//    
//    func application(_ application: UIApplication,
//                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        print(" Successfully registered for remote notifications.")
//    }
//
//    func application(_ application: UIApplication,
//                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        print(" Failed to register for remote notifications: \(error.localizedDescription)")
//    }
//}
//
//// MARK: - Firebase Messaging Delegate
//extension AppDelegate: MessagingDelegate {
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//        let token = fcmToken ?? ""
//        print(" FCM Token: \(token)")
//    }
//}
//
//// MARK: - Notification Center Delegate
//@available(iOS 10.0, *)
//extension AppDelegate: UNUserNotificationCenterDelegate {
//
//    // Foreground notification
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                willPresent notification: UNNotification,
//                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        let userInfo = notification.request.content.userInfo
//        if let messageID = userInfo[gcmMessageIDKey] {
//            print("Foreground Message ID: \(messageID)")
//        }
//        print(" Foreground Notification Payload: \(userInfo)")
//        completionHandler([.banner, .badge, .sound])
//    }
//
//    // User tapped notification
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                didReceive response: UNNotificationResponse,
//                                withCompletionHandler completionHandler: @escaping () -> Void) {
//        let userInfo = response.notification.request.content.userInfo
//        if let messageID = userInfo[gcmMessageIDKey] {
//            print(" Tapped Notification Message ID: \(messageID)")
//        }
//        print(" Tapped Notification Payload: \(userInfo)")
//        completionHandler()
//    }
//}
