//
//  UIViewController+Router.swift
//  RemoteLayout
//
//  Created by Nicolas Berthelot on 16/10/2017.
//

import Foundation


public extension UIViewController {
  
  @discardableResult
  public func x_performRoute(_ route: String, presentationType: TBPresentationType, data: Any? = nil, animated: Bool = true) -> Bool {
    let routableControllerType: TBRoutable.Type? = TBContainer.getValue(for: route)
    guard let controller = routableControllerType?.loadController(with: data, for: route) else {
        return false
    }
    self.x_present(controller, type: presentationType, data: data, animated: animated)
    return true
  }
  
  @discardableResult
  public func x_performRoute(route: TBRouter.Route, presentationType: TBPresentationType, data: Any? = nil, animated: Bool = true) -> Bool {
    return x_performRoute(route.rawValue, presentationType: presentationType, data: data, animated: animated)
  }
  
  
}
