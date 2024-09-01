//
//  Alerm.swift
//  no-neochi
//
//  Created by saki on 2024/08/26.
//

import AVFoundation
import Foundation
import UIKit
import UserNotifications

class Alerm {
    var scheduleList = ScheduleList()

    func sendNotification(DateComponents: DateComponents) {
        let content = UNMutableNotificationContent()

        content.title = "起きて！！！！"
        content.body = "あなたは寝てます！"

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)
        let request = UNNotificationRequest(
            identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)

    }

    func showAlert(in viewController: UIViewController, scedule: Schedule) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "寝落ち", message: "あなたは寝ました！！課金されます", preferredStyle: .alert)

            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                PutRegister().request(
                    handler: { result in
                        switch result {
                        case .success(let data):
                            print("register")
                        case .failure(let error):
                            print("registerError", error)
                        }
                    }, scedule: scedule)

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
    }

    //     func playSound() {
    //var player: AVAudioPlayer!
    //
    //               // AVAudioSession の設定
    //               do {
    //                   try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
    //                   try AVAudioSession.sharedInstance().setActive(true)
    //               } catch {
    //                   print("AVAudioSession の設定エラー: \(error.localizedDescription)")
    //                   return
    //               }
    //
    //               // 音声ファイルのパスを取得
    //         let music = NSDataAsset(name: "wakeup")!.data
    //
    //               do {
    //
    //                   player = try AVAudioPlayer(data: music)
    //                   player.currentTime = 0.0
    //
    //                   player.play()
    //               } catch let error as NSError {
    //                   print("音声再生エラー: \(error.localizedDescription)")
    //                   print("エラーコード: \(error.code)")
    //                   print("エラーユーザー情報: \(error.userInfo)")
    //               }
    //
    //     }
}
