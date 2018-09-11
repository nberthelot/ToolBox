//
//  NetworkerSession.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 11/09/2018.
//

import Foundation

open class TBAPISession {
  
  public var configuration: TBAPISessionConfiguration
  public weak var delegate: TBAPISessionDelegate?
  
  public init(withConfiguration configuration: TBAPISessionConfiguration) {
    self.configuration = configuration
  }
  
}

// MARK: - ERRORS
public extension TBAPISession {
  
  func computeErrors(statusCode: Int?, body: Any?, defaultError: Error?) -> [Error] {
    var errors: [Error] = []
    if let error = defaultError { errors.append(error) }
    return errors
  }
  
}
