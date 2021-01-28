//
//  Calendar.swift
//  CalendarCoreData
//
//  Created by addin on 28/01/21.
//

import Foundation

// MARK: - Calendar
struct Calendar: Codable {
    let items: [Event]
    
}

// MARK: - Event
struct Event: Codable {
    let summary: String
    let start: Start
//    let end: Start
}

// MARK: - End
struct Start: Codable {
    let date: String
    
    var formattedDate: String {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MM/dd/yyyy"

        if let date = dateFormatterGet.date(from: date) {
            return dateFormatterPrint.string(from: date)
        }
        
        return ""
    }
}

