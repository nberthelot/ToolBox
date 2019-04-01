//
//  TBEnvironment.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 11/09/2018.
//

import Foundation

public struct TBEnvironment: Hashable, Equatable, RawRepresentable {
  
  public var rawValue: String
  
  public init?(rawValue: String) {
    self.rawValue = rawValue
  }
  
  public init(_ rawValue: String) {
    self.rawValue = rawValue
  }
  
}

extension TBEnvironment {
  public static let local = TBEnvironment("local")
  public static let dev = TBEnvironment("dev")
  public static let integration = TBEnvironment("integration")
  public static let test = TBEnvironment("test")
  public static let staging = TBEnvironment("staging")
  public static let prod = TBEnvironment("prod")
}

