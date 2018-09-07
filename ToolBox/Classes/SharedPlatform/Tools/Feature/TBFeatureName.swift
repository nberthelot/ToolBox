//
//  TBFeatureName.swift
//  ToolBox
//
//  Created by Berthelot Nicolas on 04/09/2018.
//

import Foundation

extension TBFeature {
  
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
