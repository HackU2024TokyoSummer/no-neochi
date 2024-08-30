//
//  Alerm.swift
//  no-neochi
//
//  Created by saki on 2024/08/26.
//

import Foundation
import UserNotifications
import UIKit
import AVFoundation

class Alerm{
    
    func sendNotification(DateComponents: DateComponents) {
        let content = UNMutableNotificationContent()
        
        content.title = "起きて！！！！"
        content.body = "あなたは寝てます！"
        
        let trigger =  UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
    }

    func showAlert(in viewController: UIViewController) {
        let alert = UIAlertController(title: "アラート", message: "あなたは寝ています！", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default){ _ in
            
            PutNeochi().request(handler: { result in
                switch result {
                case .success(()):
                    print("寝落ち処理完了")
                case .failure(let error):
                    print("寝落ち処理失敗！")
                }
                
            })
        }
        alert.addAction(okAction)
        
        viewController.present(alert, animated: true, completion: nil)
    }
    func playSound() {
           guard let soundURL = Bundle.main.url(forResource: "alertSound", withExtension: "mp3") else {
               print("音声ファイルが見つかりません")
               return
           }
           
           do {
           } catch {
               print("音声再生エラー: \(error.localizedDescription)")
           }
       }
}
