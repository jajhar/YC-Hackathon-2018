//
//  Date+Extensions.swift
//  Hackathon
//
//  Created by James Ajhar on 6/24/18.
//  Copyright © 2018 James Ajhar. All rights reserved.
//

import Foundation

extension Date {
    
    func iso8601Format() -> String {
        return Formatter.iso8601.string(from: self)
    }
    
    func monthDayYearFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.string(from: self)
    }
    
    func ggTimestampFormat() -> String {
        let formatter = DateFormatter()
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        
        let dateString: String

        guard let oneDayAgo = Date().subtractDays(1),
            let twoDaysAgo = Date().subtractDays(2),
            let sevenDaysAgo = Date().subtractDays(7) else {
            formatter.dateFormat = "MMM dd, YYYY"
            dateString = formatter.string(from: self)
            return dateString
        }
        
        if self > oneDayAgo {
            formatter.dateFormat = "h:mm a"
            dateString = "today at " + formatter.string(from: self)
            
        } else if self > twoDaysAgo {
            formatter.dateFormat = "h:mm a"
            dateString = "yesterday at " + formatter.string(from: self)
            
        } else if self > sevenDaysAgo {
            formatter.dateFormat = "EEE h:mm a"
            dateString = formatter.string(from: self)
            
        } else {
            formatter.dateFormat = "MMM dd, YYYY"
            dateString = formatter.string(from: self)
        }
        
        return dateString
    }
    
    func subtractSeconds(_ seconds: Int) -> Date? {
        return Calendar.current.date(byAdding: .second, value: -seconds, to: self)
    }
    
    func subtractHours(_ hours: Int) -> Date? {
        return Calendar.current.date(byAdding: .hour, value: -hours, to: self)
    }
    
    func subtractDays(_ days: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: -days, to: self)
    }
    
    func subtractYears(_ years: Int) -> Date? {
        return Calendar.current.date(byAdding: .year, value: -years, to: self)
    }
}

extension Formatter {
    
    static let iso8601: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
}
