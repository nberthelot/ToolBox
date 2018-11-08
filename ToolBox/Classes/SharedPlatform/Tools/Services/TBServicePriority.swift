//
//  TBServicePriority.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 08/11/2018.
//

import Foundation

public enum TBServicePriority: Comparable {
  
  case low
  case medium
  case high
  case custom(Int)
  
  var value: Int {
    switch self {
    case .low: return 0
    case .medium: return 500
    case .high: return 1000
    case .custom(let val): return val
    }
  }
  
  public static func < (lhs: TBServicePriority, rhs: TBServicePriority) -> Bool {
    return lhs.value < rhs.value
  }
  
  public static func > (lhs: TBServicePriority, rhs: TBServicePriority) -> Bool {
    return lhs.value > rhs.value
  }
  
  public static func <= (lhs: TBServicePriority, rhs: TBServicePriority) -> Bool {
    return lhs.value <= rhs.value
  }
  
  public static func >= (lhs: TBServicePriority, rhs: TBServicePriority) -> Bool {
    return lhs.value >= rhs.value
  }
  
  public static func == (lhs: TBServicePriority, rhs: TBServicePriority) -> Bool {
    return lhs.value == rhs.value
  }
  
}
