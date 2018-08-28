//
//  TBServices.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 31/10/2017.
//

import Foundation

public struct TBServices {
  
  fileprivate static var instance = TBServices()
  fileprivate var services = [String:  TBServiceProtocol.Type]()
  
  // TODO: find a way to replace this by add(serviceType)
  public static func add<T>(_ serviceType : TBServiceProtocol.Type, for protocol: T.Type) {
    let key = String(describing: T.self)
    instance.services[key] = serviceType
  }
  
  public static func retrieve<T>() -> T {
    return retrieve(type: T.self)
  }
  public static func retrieve<T>(type : T.Type) -> T {
    let key = String(describing: T.self)
    
    guard let service = instance.services[key] else {
      precondition(false, "[TBSERVICES] services doesn't cointain \(String(describing: T.self))")
      fatalError()
    }
    
    let srv = service.loadService()
    return srv as! T
  }
  
}

