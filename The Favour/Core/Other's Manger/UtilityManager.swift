//
//  UtilityManager.swift
//  The Favour
//
//  Created by Atta khan on 20/07/2023.
//

import Foundation

class UtilityManager {
    
    static let shared = UtilityManager()
    private init() {}

    
    func getTimeAgoString(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: dateString) else {
            return "Invalid Date"
        }

        let now = Date()
        let components = Calendar.current.dateComponents([.weekOfYear, .day, .minute, .second], from: date, to: now)

        if let weeks = components.weekOfYear, weeks > 0 {
            return "\(weeks) week\(weeks == 1 ? "" : "s") ago"
        } else if let days = components.day, days > 0 {
            return "\(days) day\(days == 1 ? "" : "s") ago"
        } else if let minutes = components.minute, minutes > 0 {
            return "\(minutes) minute\(minutes == 1 ? "" : "s") ago"
        } else if let seconds = components.second, seconds > 0 {
            return "\(seconds) second\(seconds == 1 ? "" : "s") ago"
        } else {
            return "Just now"
        }
    }
    
}
