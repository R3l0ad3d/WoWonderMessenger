//
//  UIImageViewExtension.swift
//  ScanQR
//
//  Created by Dev. Mohmd on 8/30/20.
//  Copyright © 2020 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    
    public var isBeforeToday: Bool {
        get {
            return self.compare(Date()) == .orderedAscending
        }
    }
    
    public func formatDate(_ format: String, timeZone: TimeZone = TimeZone(abbreviation: "GMT")!) -> String {
        return self.convertDateToString(format, timeZone: timeZone)
    }
    
    // Convert local time to UTC (or GMT)
    public func toGlobalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }

    // Convert UTC (or GMT) to local time
    public func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    private func convertDateToString(_ format: String, timeZone: TimeZone = TimeZone(abbreviation: "GMT")!) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timeZone
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}

