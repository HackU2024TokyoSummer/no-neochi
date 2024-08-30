//
//  formatter.swift
//  no-neochi
//
//  Created by saki on 2024/08/25.
//

import Foundation

class Formatter {
    func formatDate(_ date: Date) -> String {
        let calendar = Calendar.current
        let formatter = DateFormatter()

        formatter.dateFormat = "M/d"
        let dateString = formatter.string(from: date)

        let weekdayIndex = calendar.component(.weekday, from: date)
        let weekdaySymbols = ["Sun.", "Mon.", "Tue.", "Wed.", "Thu.", "Fri.", "Sat."]
        let weekday = weekdaySymbols[weekdayIndex - 1]
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let time = timeFormatter.string(from: date)
        return "\(dateString) \(weekday)　\(time)"
    }

    func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}
