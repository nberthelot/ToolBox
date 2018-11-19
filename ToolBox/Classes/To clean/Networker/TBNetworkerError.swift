//
//  TBNetworkerError.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 11/09/2018.
//

import Foundation

public enum TBNetworkerError: Int {
  case `default`        = -1
  case invalidRequest   = 100
  case responseParsing  = 200

  public var domain: String { return "com.toolbox.networker" }
  public var code: Int { return self.rawValue }
  public var userInfo: [String: Any] {
    var localizedDescription: String = ""
    let failureReason: String = ""
    let recoverySuggestion: String = ""
    switch(self) {
    case .default:
      localizedDescription = "An unkown error occured"
    case .invalidRequest:
      localizedDescription = "Invalid request"
    case .responseParsing:
      localizedDescription = "Response parsing failed"
    }
    
    return [
      NSLocalizedDescriptionKey: localizedDescription,
      NSLocalizedFailureReasonErrorKey: failureReason,
      NSLocalizedRecoverySuggestionErrorKey: recoverySuggestion,
    ]
  }
  
}

extension TBNetworkerError: LocalizedError {
  
  public var errorDescription: String? {
    return (userInfo[NSLocalizedDescriptionKey] as? String)
  }
  
  public var failureReason: String? {
    return (userInfo[NSLocalizedFailureReasonErrorKey] as? String)
  }
  
  public var recoverySuggestion: String? {
    return (userInfo[NSLocalizedRecoverySuggestionErrorKey] as? String)
  }
}
