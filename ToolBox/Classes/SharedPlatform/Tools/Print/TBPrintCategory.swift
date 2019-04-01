//
//  TBPrintCategory.swift
//  ToolBox
//
//  Created by Berthelot Nicolas on 13/09/2018.
//

import Foundation


public extension TBPrint {
  
  struct Category : Hashable, Equatable, RawRepresentable {
    public var rawValue: String
    
    public init?(rawValue: String) {
      self.rawValue = rawValue
    }
    
    public init(_ rawValue: String) {
      self.rawValue = rawValue
    }

  }
  
}

public extension TBPrint.Category {
  
  static let network = TBPrint.Category("network")
  static let database = TBPrint.Category("database")
  static let data = TBPrint.Category("data")
  static let file = TBPrint.Category("file")
  static let service = TBPrint.Category("service")
  static let ui = TBPrint.Category("ui")
  static let none = TBPrint.Category("none")
  static let all = TBPrint.Category("all")
  
}
