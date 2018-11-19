//
//  APIModelProtocol.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 11/09/2018.
//

import Foundation

public protocol TBAPIModelProtocol {
  
  init?(fromApi data: Any)
  
}

public extension TBAPIModelProtocol {
  
  init?(fromApi data: Any) {
    return nil
  }
  
}
