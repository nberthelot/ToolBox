//
//  TBServiceDefinition.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 08/11/2018.
//

import Foundation

struct TBServiceDefinition {
  let serviceType : TBServiceProtocol.Type
  let dependencies: DependencySequence?
  
  init(serviceType : TBServiceProtocol.Type, dependencies: DependencySequence?) {
    self.serviceType = serviceType
    self.dependencies = dependencies
  }
  
}
