//
//  TBServiceDefinition.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 08/11/2018.
//

import Foundation

struct TBServiceDefinition {
  let priority: TBServicePriority
  let serviceType : TBServiceProtocol.Type
  let dependencies: DependencySequence?
  
  init(priority: TBServicePriority,  serviceType : TBServiceProtocol.Type, dependencies: DependencySequence?) {
    self.priority = priority
    self.serviceType = serviceType
    self.dependencies = dependencies
  }
  
}
