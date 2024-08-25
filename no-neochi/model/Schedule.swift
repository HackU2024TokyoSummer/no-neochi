//
//  schedule.swift
//  no-neochi
//
//  Created by saki on 2024/08/24.
//

import Foundation

struct Schedule: Identifiable {
    let id = UUID()
    var date: Date
    var time: Date
    var billing = Int()

}
