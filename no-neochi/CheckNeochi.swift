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
        let writeTypes = Set([
              HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!
          ])
        
        healthStore.requestAuthorization(toShare: writeTypes, read: readTypes, completion: { success, error in
            if success == false {
                print("データにアクセスできません")
                return
            }else{
                print("できた！")
              
            }
            
        })
    }
    func setObserver(in viewController: UIViewController) {
        let sampleType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        let observerQuery = HKObserverQuery(sampleType: sampleType, predicate: nil) { [weak self] query, completionHandler, error in
            guard let self = self else { return }
            if error != nil {
                print("Observer Query Error: \(error!.localizedDescription)")
                completionHandler()
                return
            }
            
            self.checkRecentSleepData(in: viewController)
            completionHandler()
        }
        
        healthStore.execute(observerQuery)
        
        healthStore.enableBackgroundDelivery(for: sampleType, frequency: .immediate) { success, error in
            if let error = error {
                print("Background Delivery Error: \(error.localizedDescription)")
            }
        }
    }
    
    func checkRecentSleepData(in viewController: UIViewController) {
        let sampleType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.date(byAdding: .hour, value: -1, to: Date())!, end: Date(), options: [])
        
        let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)]) { [weak self] (_, results, error) in
          
            
            if let error = error {
                print("Query Error: \(error.localizedDescription)")
                return
            }
            
            guard let samples = results as? [HKCategorySample] else {
                print("Error: Results could not be cast to [HKCategorySample]")
                return
            }
            
            for sample in samples {
                if sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue {
                    DispatchQueue.main.async {
                        var components = DateComponents()
                        components.second = 600 // 5秒後に通知
                       
              
                 Alerm().sendNotification(DateComponents: components)
                        Alerm().showAlert(in: viewController)
           
                        print("ベッドにいます！")
                    }
                    return
                }
            }
        }
        
        healthStore.execute(query)
    }

    func insertSampleData(in viewController: UIViewController) {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            print("Sleep Analysis Type is no longer available in HealthKit")
            return
        }
        
        let startDate = Calendar.current.date(byAdding: .hour, value: -2, to: Date())!
        let endDate = Date()
        
        let sleepSample = HKCategorySample(
            type: sleepType,
            value: HKCategoryValueSleepAnalysis.inBed.rawValue,
            start: startDate,
            end: endDate,
            metadata: nil
        )
        
        healthStore.save(sleepSample) { success, error in
            if let error = error {
                print("Error saving sample: \(error.localizedDescription)")
            } else {
                self.checkRecentSleepData(in: viewController)
                print("Sample saved successfully: \(success)")
            }
        }
    }

}
