//
//  Date.swift
//  Lootz
//
//  Created by meshal on 9/17/25.
//

import Foundation
import SwiftUI

func relativeTimeLeft(from dateString: String?) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    formatter.timeZone = .current
    formatter.locale = .current
    
    guard let dateString, let date = formatter.date(from: dateString) else {
        return ""
    }
    
    let calendar = Calendar.current
    
    if calendar.isDateInToday(date) {
        return "Today"
    } else if calendar.isDateInTomorrow(date) {
        return "Tomorrow"
    } else if calendar.isDateInYesterday(date) {
        return "Yesterday"
    } else {
        let relativeFormatter = RelativeDateTimeFormatter()
        relativeFormatter.unitsStyle = .full
        return relativeFormatter.localizedString(for: date, relativeTo: Date())
    }
}

func getDateTint(_ date: String) -> Color? {
    switch date.lowercased() {
    case "yesterday", "today":
        return Color.red
    case "tomorrow":
        return Color.orange
    default:
        return nil
    }
}
