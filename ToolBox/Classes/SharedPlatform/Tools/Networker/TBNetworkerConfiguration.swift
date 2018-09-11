//
//  NetworkerConfiguration.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 11/09/2018.
//

import Foundation

open class TBNetworkerConfiguration {
  
  open var hostPath: String?
  open var headers = [String: String]()

  public init() { }
  
  public init(hostPath: String? = nil) {
    self.hostPath = hostPath
  }
  
}
