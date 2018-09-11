//
//  NetworkerConfiguration.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 11/09/2018.
//

import Foundation

public class TBNetworkerConfiguration {
  
  var hostPath: String?
  var headers = [String: String]()

  public init() { }
  
  public init(hostPath: String? = nil) {
    self.hostPath = hostPath
  }
  
}
