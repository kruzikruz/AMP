//
//  AppDelegate.swift
//  AMP
//
//  Created by Kornel Krużewski on 03/09/2023.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseMessaging
import FirebaseAnalytics
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, MessagingDelegate {
    
    let gcmMessageIDKey = "gcm.message_id"
    var app: AMPApp?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        //FirebaseConfiguration.shared.setLoggerLevel(.debug)
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        application.registerForRemoteNotifications()
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        return true
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        let deviceToken: [String: String] = ["token": fcmToken ?? ""]
        print("🚨 FCM Token: \(deviceToken)")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("APNS Token:", token)
        
        // Tutaj ustawiasz APNS token przed pobraniem FCM token
        Messaging.messaging().apnsToken = deviceToken
        
        // Subskrypcja do tematu "weather" po uzyskaniu tokenu APNS
        Messaging.messaging().subscribe(toTopic: "AMP_TEST") { error in
            if let error = error {
                print("Error subscribing to topic: \(error.localizedDescription)")
            } else {
                print("Subscribed to AMP topic")
            }
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications:", error.localizedDescription)
    }
}



@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {

    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo

        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

        print(userInfo)
    
        // Change this to your preferred presentation option
        completionHandler([[.banner, .badge, .sound]])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo

        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID from userNotificationCenter didReceive: \(messageID)")
        }

        print(userInfo)
        
        if let deepLink = userInfo["link"] as? String, let url = URL(string: deepLink) {
            Task {
                print("✅ found deep url \(url)")
                await app?.handleDeeplinking(from: url)
            }
            print("✅ found deep deepLink \(deepLink)")
        }

        
        completionHandler()
    }
}


