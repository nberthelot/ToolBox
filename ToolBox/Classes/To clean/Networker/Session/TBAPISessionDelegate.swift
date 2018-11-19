//
//  APISessionRefresherProtocol.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 11/09/2018.
//

import Foundation

public protocol TBAPISessionDelegate: class {
  
  func beginRequest(_ request: TBAPIRequestModel, beginHandler: @escaping ((_ result: Bool, _ error: Error?) -> ()))
  func refreshSession(_ refreshHandler: @escaping ((_ success: Bool, _ error: Error?) -> ()))
}

extension TBAPISessionDelegate {
  
  func beginRequest(_ request: TBAPIRequestModel, beginHandler: @escaping ((_ result: Bool, _ error: Error?) -> ())) {
    beginHandler(true, nil)
  }
  
  func refreshSession(_ refreshHandler: @escaping ((_ success: Bool, _ error: Error?) -> ())) {
    refreshHandler(false, nil)
  }
  
}
