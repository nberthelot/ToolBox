//
//  TBRouter.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 16/10/2017.
//

import Foundation

public struct TBRouter {
  
  public static func addRoute(_ route: String, routableClass: TBRoutable.Type) {
    TBContainer.add(routableClass, for: route)
  }
  
  public static func remove(_ route: String) {
    TBContainer<TBRoutable.Type>.removeValue(for: route)
  }
  
  public static func route(_ route: String, with data: Any?) -> UIViewController? {
    let routable: TBRoutable.Type? = TBContainer.getValue(for: route)
    return routable?.loadController(with: data, for: route)
  }
  
}

// MARK: - CONFIGURATION
extension TBRouter {
  
  @discardableResult
  public static func loadRoutes(from url: URL, asynchronous: Bool = false, completion: ((Bool) -> Void)? = nil) -> Bool {
    if asynchronous == false {
      let data = try? Data(contentsOf: url)
      let json = try? JSONSerialization.jsonObject(with: data!)
      return TBRouter.addRoutes(from:  json as? [String: [String: Any]])
    }
    else {
      DispatchQueue.global(qos: .background).async {
        let data = try? Data(contentsOf: url)
        let json = try? JSONSerialization.jsonObject(with: data!)
        DispatchQueue.main.async {
          completion?(TBRouter.addRoutes(from:  json as? [String: [String: Any]]))
        }
      }
      return true
    }
  }
  
  fileprivate static func addRoutes(from data: [String: [String: Any]]?) -> Bool {
    guard let routesInfos = data else { return false }
    
    for (route, infos) in routesInfos {
      guard let className = infos["class"] else {
        return false
      }
      let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? ""
      if let routableClass = NSClassFromString("\(bundleName).\(className)") as? TBRoutable.Type {
        TBRouter.addRoute(route, routableClass: routableClass)
      }
      else if let routableClass = NSClassFromString("\(className)") as? TBRoutable.Type {
        TBRouter.addRoute(route, routableClass: routableClass)
      }
      else {
        tbPrint("[TBROUTER] Fail to add route \(route) with infos: \(infos)", category: .ui)
      }
    }
    return true
  }
  
}


