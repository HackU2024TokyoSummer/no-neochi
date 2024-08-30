//
//  no_neochiApp.swift
//  no-neochi
//
//  Created by saki on 2024/08/23.
//

import SwiftUI
import Foundation
import UIKit

class AppDelegate:NSObject,UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("許可されました！")
            }else{
                print("拒否されました...")
            }
        }
        return true
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([[.banner, .list, .sound]])
    }
    func application(_ application: UIApplication, continue continueUserActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        // appLinksの場合、activityTypeがNSUserActivityTypeBrowsingWebになる
        guard  continueUserActivity.activityType == NSUserActivityTypeBrowsingWeb, let url =  continueUserActivity.webpageURL else { return false }

      
        return true
    }
}

@main
struct no_neochiApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {

        WindowGroup {
            
//LoginView()

   ButtomNavigationView()
        }
    }
}
