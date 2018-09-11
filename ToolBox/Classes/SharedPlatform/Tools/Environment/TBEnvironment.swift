//
//  TBEnvironment.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 11/09/2018.
//

import Foundation

public struct TBEnvironment {
  
  public struct Name: Hashable, Equatable, RawRepresentable {
    
    public var rawValue: String
    
    public init?(rawValue: String) {
      self.rawValue = rawValue
    }
    
    public init(_ rawValue: String) {
      self.rawValue = rawValue
    }
  }
  
}

public extension TBEnvironment.Name {
  public static let local = TBEnvironment.Name("local")
  public static let dev = TBEnvironment.Name("dev")
  public static let integration = TBEnvironment.Name("integration")
  public static let test = TBEnvironment.Name("test")
  public static let staging = TBEnvironment.Name("staging")
  public static let prod = TBEnvironment.Name("prod")
}

