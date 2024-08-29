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
        let sampleType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        let observerQuery = HKObserverQuery(sampleType: sampleType, predicate: nil) { [weak self] query, completionHandler, error in
            guard let self = self else { return }
            if error != nil {
                print("Observer Query Error: \(error!.localizedDescription)")
                completionHandler()
                return
            }
            
            self.checkRecentSleepData()
            completionHandler()
        }
        
        healthStore.execute(observerQuery)
        
        healthStore.enableBackgroundDelivery(for: sampleType, frequency: .immediate) { success, error in
            if let error = error {
                print("Background Delivery Error: \(error.localizedDescription)")
            }
            print("Background Delivery Enabled: \(success)")
        }
    }
    
    func checkRecentSleepData() {
        let sampleType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.date(byAdding: .hour, value: -1, to: Date())!, end: Date(), options: [])
        
        let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)]) { [weak self] (_, results, error) in
            guard let self = self, let samples = results as? [HKCategorySample] else {
                print("Query Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            for sample in samples {
                if sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue {
                    DispatchQueue.main.async {
                        let components = Calendar.current.dateComponents([.calendar, .year, .month, .day], from: Date())
                        Alerm().sendNotification(DateComponents: components)
                        print("ベッドにいます！")
                    }
                    return
                }
            }
        }
        
        healthStore.execute(query)
    }
}
