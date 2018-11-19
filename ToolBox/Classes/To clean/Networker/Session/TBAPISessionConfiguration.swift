//
//  NetworkerSessionConfiguration.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 11/09/2018.
//

import Foundation

open class TBAPISessionConfiguration {
  
  open var baseUrl: URL
  open var headers = [String: String]()
  open var authorization: TBAuthorizationType? {
    didSet {
      self.refreshAuthorizationInHeaders()
    }
  }
  
  open var userAgent: String? {
    didSet {
      self.refreshUserAgentInHeaders()
    }
  }

  public required init(baseUrl: URL, authorization: TBAuthorizationType? = nil, userAgent: String? = nil) {
    self.baseUrl = baseUrl
    self.authorization = authorization
    self.userAgent = userAgent
    self.refreshAuthorizationInHeaders()
    self.refreshUserAgentInHeaders()
  }
  
}

// MARK: - UTILS
extension TBAPISessionConfiguration {
  
  private func refreshAuthorizationInHeaders() {
    headers[TBHeaderKeys.authorization] = authorization?.value ?? nil
  }
  
  private func refreshUserAgentInHeaders() {
    headers[TBHeaderKeys.userAgent] = userAgent ?? nil
  }
  
}
