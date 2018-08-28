//
//  RLLoggerServiceProtocol.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 02/11/2017.
//

import Foundation

public protocol TBLoggerServiceProtocol: TBServiceProtocol {
  func logError(_ message: String)
  func logWarn(_ message: String)
  func logInfo(_ message: String)
  func logDebug(_ message: String)
  func logVerbose(_ message: String)
}
