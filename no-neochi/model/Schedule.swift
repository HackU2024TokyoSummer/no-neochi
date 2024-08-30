//
//  schedule.swift
//  no-neochi
//
//  Created by saki on 2024/08/24.
//

import Foundation

struct Schedule: Identifiable, Decodable {
    var id = Int()
    var date = Date()
    var billing = Int()
    
}
extension Schedule {
    func toCreateScheduleParameters() ->[String: Any]{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
               let dateString = dateFormatter.string(from: date)
        return [
            "wake_time": dateString,
            "billing": self.billing
        ]
        
    }
}
