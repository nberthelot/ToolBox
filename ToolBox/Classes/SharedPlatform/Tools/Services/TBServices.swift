//
//  TBServices.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 31/10/2017.
//

import Foundation

public typealias DependencyType = Any.Type
public typealias DependencyDefinition = (`protocol`: DependencyType, serviceType: TBServiceProtocol.Type?)
public typealias DependencySequence = [DependencyDefinition]
public typealias DependencyInjection = (`protocol`: DependencyType, service: TBServiceProtocol)
public typealias DependencyInjectionSequence = [(`protocol`: DependencyType, service: TBServiceProtocol)]


open class TBServices {
  
  fileprivate static var instance = TBServices()
  fileprivate var services = [String: [TBServiceDefinition]]()
  
}

// MARK: ADD
extension TBServices {

  public static func add(_ serviceType : TBServiceProtocol.Type,
                            for protocol: Any.Type,
                            dependencies: DependencySequence? = nil) {
    let serviceDefinition = TBServiceDefinition(serviceType: serviceType, dependencies: dependencies)
    precondition(validate(serviceDefinition: serviceDefinition), "[TBSERVICES] Fail to validate dependencies \(serviceType)")
    let key = keyFor(type: `protocol`.self)
    var serviceDefinitions = instance.services[key, default:[]]
    serviceDefinitions.append(serviceDefinition)
    instance.services[key] = serviceDefinitions
  }
  
  public static func add(_ serviceType : TBServiceProtocol.Type,
                            for protocol: Any.Type,
                            dependencies: [DependencyType]) {
    var dep = DependencySequence()
    dependencies.forEach {
      dep.append((protocol: $0, serviceType: nil))
    }
    add(serviceType, for: `protocol`, dependencies: dep)
  }
  
}

// MARK: RETREIVE
extension TBServices {
  
  private static func retrieve(withKey key: String) -> TBServiceProtocol? {
    guard let serviceDefinition = instance.services[key]?.last else {
      precondition(false, "[TBSERVICES] services doesn't cointain \(key)")
      fatalError()
    }
    return load(serviceDefinition: serviceDefinition)
  }
  
  private static func load(serviceDefinition: TBServiceDefinition) -> TBServiceProtocol? {
    let dependencies: DependencyInjectionSequence? = serviceDefinition.dependencies?.compactMap { dependency in
      let dependencyKey = keyFor(type: dependency.protocol.self)
      if let services = instance.services[dependencyKey] {
        
        guard let serviceType = dependency.serviceType else {
          if let def = services.last, let srv = load(serviceDefinition: def)  {
            return (protocol: dependency.protocol, service: srv)
          }
          return nil
        }
        
        for def in services where def.serviceType == serviceType {
          if let srv = load(serviceDefinition: def) {
            return (protocol: dependency.protocol, service: srv)
          }
        }
      }
      return nil
    }
    return serviceDefinition.serviceType.loadService(dependencies: dependencies)
  }
  
  public static func retrieve<T>(type : T.Type) -> T {
    return retrieve(withKey: keyFor(type: T.self)) as! T
  }
  
  public static func retrieve<T>() -> T {
    return retrieve(type: T.self)
  }
  
}

// MARK: REMOVE
extension TBServices {

  public static func remove<T>(serviceProtocol: T.Type) {
    let key = keyFor(type: T.self)
    instance.services.removeValue(forKey: key)
  }
  
  public static func clearAll(){
    instance.services.removeAll()
  }
  
}

// MARK: UTILITIES
extension TBServices {
  
  private static func keyFor(type : Any.Type) -> String {
    return String(describing: type.self)
  }
  
  
  private static func validate(serviceDefinition: TBServiceDefinition) -> Bool {
    return validate(dependencies: serviceDefinition.serviceType.mandatoryDependencies)
  }
  
  static func validate(dependencies: [DependencyType]) -> Bool {
    for dependency in dependencies{
      let dependencyKey = keyFor(type: dependency.self)
      guard let services = instance.services[dependencyKey], services.isEmpty == false else {
        return false
      }
    }
    return true
  }
  
}
