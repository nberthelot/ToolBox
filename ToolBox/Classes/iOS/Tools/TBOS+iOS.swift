//
//  TBOS.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 22/11/2017.
//

import Foundation

public extension TBOS {
  
  static var iOS11IsAvailable: Bool {
    if #available(iOS 11.0, *) {
      return true
    }
    return false
  }
  
}
