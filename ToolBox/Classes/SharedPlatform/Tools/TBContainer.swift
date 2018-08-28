//
//  TBContainer.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 03/07/2017.
//
//

import Foundation

fileprivate var containerInstances = [String: Any]()

public class TBContainer<T> {
  
  fileprivate var content = [String: T]()
  
  class var shared : TBContainer<T> {
    let singletonIdentifier = String(describing: T.self)
    if let singleton = containerInstances[singletonIdentifier] {
      return singleton as! TBContainer<T>
    }
    else {
      let singleton = TBContainer<T>()
      containerInstances[singletonIdentifier] = singleton
      return singleton
    }
  }
  
  public static func add(_ value: T, for identifier: String) {
    TBContainer<T>.shared.content[identifier] = value
  }
  
  public static func removeValue(for identifier: String) {
    TBContainer<T>.shared.content.removeValue(forKey: identifier)
  }
  
  public static func getValue(for identifier: String) -> T? {
    return TBContainer<T>.shared.content[identifier]
  }
      
}

