//
//  History.swift
//  no-neochi
//
//  Created by saki on 2024/08/30.
//

import Foundation
struct History: Identifiable, Decodable{
    var id = UUID()
    var wake_time: Date
    var billing: Int
}
struct HistoryResponse: Decodable {
    var total_money: Int
    var history: [History]
}
