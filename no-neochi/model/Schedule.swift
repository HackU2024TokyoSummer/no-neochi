//
//  schedule.swift
//  no-neochi
//
//  Created by saki on 2024/08/24.
//

import Foundation

struct Schedule: Identifiable, Decodable, Equatable {
    var id = Int()
    var wake_time : Date
    var billing : Int
    var access_id: String
    var order_id: String
    
}
extension Schedule {
    func toCreateScheduleParameters() ->[String: Any]{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = dateFormatter.string(from: wake_time)
        return [
            "wake_time": dateString,
            "billing": self.billing
        ]
        
    }
}
