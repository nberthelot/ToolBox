//
//  NetworkerSessionConfiguration.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 11/09/2018.
//

import Foundation


public class TBAPISessionConfiguration {
  
  var baseUrl: URL
  var headers = [String: String]()
  var authorization: TBAuthorizationType? {
    didSet {
      self.refreshAuthorizationInHeaders()
    }
  }
  
  var userAgent: String? {
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
