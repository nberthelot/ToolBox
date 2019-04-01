//
//  TBBaseService.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 08/11/2018.
//

import Foundation

open class TBBaseService: TBServiceProtocol {
  
  private var dependencies: DependencyInjectionSequence?
  
  open class var mandatoryDependencies: [DependencyType] { return [] }
  
  required public init() { }
  
  open class func loadService(dependencies: DependencyInjectionSequence?) -> Self {
    let s = self.init()
    s.set(dependencies: dependencies)
    return s
  }
  
  public func set(dependencies: DependencyInjectionSequence?) {
    self.dependencies = dependencies
  }
  
}

public extension TBBaseService {
  
  func retrieveService<T>() -> T {
    guard let service: T = retrieveOptionalService() else {
      precondition(false, "[TBSERVICE] dependency doesn't exist: \(String(describing: T.self))")
      fatalError()
    }
    return service
  }
  
  func retrieveOptionalService<T>() -> T?  {
    guard let dependencies = dependencies else { return nil }
    for dependencie in dependencies {
      if dependencie.protocol is T.Type {
        return dependencie.service as? T
      }
    }
    return nil
  }
  
  func retrieveService<T>(type : T.Type) -> T {
    return retrieveService()
  }
  
  func retrieveOptionalService<T>(type : T.Type) -> T? {
    return retrieveOptionalService()
  }
  
}

// SINGLETON EXEMPLE
/*
 
 final class TBBaseSingeltonService: TBBaseService {
 
 private static var instance: TBBaseSingeltonService = TBBaseSingeltonService()
 
 public override class func loadService(dependencies: DependencyInjectionSequence?) -> TBBaseSingeltonService {
 instance.set(dependencies: dependencies)
 return instance
 }
 }
 
 */
