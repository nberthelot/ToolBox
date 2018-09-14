//
//  TBPrintCategory.swift
//  ToolBox
//
//  Created by Berthelot Nicolas on 13/09/2018.
//

import Foundation


public extension TBPrint {
  
  public struct Category : Hashable, Equatable, RawRepresentable {
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
  
  public static let network = TBPrint.Category("network")
  public static let database = TBPrint.Category("database")
  public static let data = TBPrint.Category("data")
  public static let file = TBPrint.Category("file")
  public static let service = TBPrint.Category("service")
  public static let ui = TBPrint.Category("ui")
  public static let none = TBPrint.Category("none")
  public static let all = TBPrint.Category("all")
  
}
