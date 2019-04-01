//
//  Date+Tools.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 29/11/2017.
//

import Foundation

public extension Date {
  
  var x_milliseconds: Int64 {
    return Int64(self.timeIntervalSince1970 * Double(1_000))
  }
  
  static func x_from(milliseconds: Int64) -> Date {
    let timeInterval = TimeInterval(milliseconds) / TimeInterval(1_000)
    return Date(timeIntervalSince1970: timeInterval)
  }
  
}
