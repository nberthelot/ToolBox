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


extension UIViewController {
  
  open class var x_mandatoryServices: [DependencyType] { return [] }

  public static func x_validateMandatoryServices() -> Bool {
    return TBServices.validate(dependencies: x_mandatoryServices)
  }
  
}

extension UIView {
  
  open class var x_mandatoryServices: [DependencyType] { return [] }
  
  public static func x_validateMandatoryServices() -> Bool {
    return TBServices.validate(dependencies: x_mandatoryServices)
  }
  
}
