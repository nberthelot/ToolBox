//
//  TBServices.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 31/10/2017.
//

import Foundation

public typealias DependencyDefinition = (`protocol`: Any.Type, serviceType: Any.Type?)
public typealias DependencySequence = [DependencyDefinition]

public typealias DependencyInjection = (`protocol`: Any.Type, service: TBServiceProtocol)
public typealias DependencyInjectionSequence = [(`protocol`: Any.Type, service: TBServiceProtocol)]


open class TBServices {
  
  fileprivate static var instance = TBServices()
  fileprivate var services = [String: [TBServiceDefinition]]()
  
}

// MARK: ADD
extension TBServices {

  public static func add<T>(_ serviceType : TBServiceProtocol.Type,
                            for protocol: T.Type,
                            priority: TBServicePriority = .high,
                            dependencies: DependencySequence? = nil) {
    
    let serviceDefinition = TBServiceDefinition(priority: priority, serviceType: serviceType, dependencies: dependencies)
    let key = keyFor(type: T.self)
    var serviceDefinitions = instance.services[key, default:[]]
    serviceDefinitions.append(serviceDefinition)
    instance.services[key] = sort(servicesDefinition: serviceDefinitions)
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
      let serivceType = dependency.serviceType
      let dependencyKey = keyFor(type: dependency.protocol.self)
      for def in instance.services[dependencyKey]! {
        if def.serviceType == serivceType, let srv = load(serviceDefinition: def) {
          return (protocol: dependency.protocol, service: srv)
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
  
}

// MARK: UTILITIES
extension TBServices {
  
  private static func keyFor(type : Any.Type) -> String {
    return String(describing: type.self)
  }
  
  
  private static func sort(servicesDefinition: [TBServiceDefinition]) -> [TBServiceDefinition] {
    return servicesDefinition.sorted {
     return $0.priority < $1.priority
    }
  }
  
}
