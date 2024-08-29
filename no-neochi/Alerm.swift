//
//  Alerm.swift
//  no-neochi
//
//  Created by saki on 2024/08/26.
//

import Foundation
import UserNotifications
import UIKit

class Alerm{
    
    func sendNotification(DateComponents: DateComponents) {
        let content = UNMutableNotificationContent()
        content.title = "起きて！！！！"
        content.body = "あなたは寝てます！"
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: DateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "通知", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
