//
//  CheckNeochi.swift
//  no-neochi
//
//  Created by saki on 2024/08/25.
//

import Foundation
import SwiftUI
import HealthKit
import HealthKitUI
class CheckNeochi {
    let healthStore = HKHealthStore()
    func checkPermistion(){
   
            let readTypes = Set([
                HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!
            ])
             
            healthStore.requestAuthorization(toShare: [], read: readTypes, completion: { success, error in
                if success == false {
                    print("データにアクセスできません")
                    return
                }
            })
    }
    func setObserver() {
            let sampleType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!
            var observerQuery = HKObserverQuery(sampleType: sampleType, predicate: nil, updateHandler: { query, completionHandler, error in
                if error != nil { return }
                // 睡眠データの追加が検知された場合にここに来る
                print("ねました")
                // 直近一時間の睡眠データを取得
                let query = HKSampleQuery(sampleType: sampleType,
                                          predicate: HKQuery.predicateForSamples(withStart: Calendar.current.date(byAdding: .hour, value: -1, to: Date())!, end: Date(), options: []),
                                          limit: HKObjectQueryNoLimit,
                                          sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: true)]){ (query, results, error) in
                    
                    guard error == nil else {
                        completionHandler()
                        print("error");
                        return
                        
                    }
                
                    if let sample = results as? [HKCategorySample] {
                        // 追加された睡眠データを用いた処理を書く
                    }
                }
            })
            
            healthStore.execute(observerQuery)
            
            // バックグランドでのヘルスケアデータの更新検知を有効にする
            healthStore.enableBackgroundDelivery(for: sampleType, frequency: .immediate) { success, error in
                if let error = error {
                    print(error)
                }
                print(success)
            }
        }


}
