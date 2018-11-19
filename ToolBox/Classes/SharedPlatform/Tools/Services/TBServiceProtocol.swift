//
//  TBService.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 31/10/2017.
//

import Foundation

public protocol TBServiceProtocol {
  static func loadService(dependencies: DependencyInjectionSequence?) -> Self
  static var mandatoryDependencies: [DependencyType] { get }
  init()
}

public protocol TBSValidateServiceDependencies {
  static var mandatoryServices: [DependencyType] { get }
}

public extension TBSValidateServiceDependencies {
  
  public static func x_validateMandatoryServices() -> Bool {
    return TBServices.validate(dependencies: mandatoryServices)
  }
  
}

