//
//  TBLoggerService.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 02/11/2017.
//

import Foundation

public struct TBLoggerService: TBLoggerServiceProtocol {
  
  public static func loadService() -> TBLoggerService {
    return TBLoggerService()
  }
  
  public func logError(_ message: String) {
    tbPrint("[ERROR]\(message)", category: .service)
  }
  
  public func logWarn(_ message: String) {
    tbPrint("[WARN]\(message)", category: .service)
  }
  
  public func logInfo(_ message: String) {
    tbPrint("[INFO]\(message)", category: .service)
  }
  
  public func logDebug(_ message: String) {
    tbPrint("[DEBUG]\(message)", category: .service)
  }
  
  public func logVerbose(_ message: String) {
    tbPrint("[VERB]\(message)", category: .service)
  }
  
}
