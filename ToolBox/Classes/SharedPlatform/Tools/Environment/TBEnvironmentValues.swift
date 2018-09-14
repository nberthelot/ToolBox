//
//  TBEnvironmentValues.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 11/09/2018.
//

import Foundation

public struct TBEnvironmentValues<T> {
  
  private var values = [String: T]()
  
  public init(_ envs: (TBEnvironment, T)...) {
    var values = [String: T]()
    envs.forEach {
      values[$0.0.rawValue] = $0.1
    }
    self.values = values
  }
  
  public func unwrappedValue(for environmentType: TBEnvironment) -> T {
    return values[environmentType.rawValue]!
  }
  
  public func value(for environmentType: TBEnvironment) -> T? {
    return values[environmentType.rawValue]
  }
  
}
