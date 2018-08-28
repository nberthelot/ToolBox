//
//  TBFeatureFlag.swift
//  ToolBox
//
//  Created by Berthelot Nicolas on 05/07/2018.
//

import Foundation

public struct TBFeatureFlag {
  
  public let name: TBFeatureFlag.Name
  public let enabled: Bool
  
  init(name: TBFeatureFlag.Name, enabled: Bool) {
    self.name = name
    self.enabled = enabled
  }
  
}

extension TBFeatureFlag {
  
  public struct Name : Hashable, Equatable, RawRepresentable {
    
    public var rawValue: String
    
    public init(_ rawValue: String) {
      self.rawValue = rawValue
    }
    
    public init(rawValue: String) {
      self.rawValue = rawValue
    }
    
  }
  
}
