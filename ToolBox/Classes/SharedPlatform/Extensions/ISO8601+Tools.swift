//
//  ISO8601+Tools.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 23/02/2017.
//  Copyright © 2017 Berthelot Nicolas. All rights reserved.
//

import Foundation

extension Date {
  
  public static let x_iso8601DateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
  }()
  
  public static let x_iso8601Formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
    return formatter
  }()
  
  public var x_iso8601Date: String {
    return Date.x_iso8601DateFormatter.string(from: self)
  }
  
  public var x_iso8601: String {
    return Date.x_iso8601Formatter.string(from: self)
  }
}

extension String {
  
  public var x_dateFromISO8601Date: Date? {
    return Date.x_iso8601DateFormatter.date(from: self)
  }
  
  public var x_dateFromISO8601: Date? {
    return Date.x_iso8601Formatter.date(from: self)
  }
}
