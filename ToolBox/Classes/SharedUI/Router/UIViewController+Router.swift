//
//  UIViewController+Router.swift
//  RemoteLayout
//
//  Created by Nicolas Berthelot on 16/10/2017.
//

import Foundation


public extension UIViewController {
  
  @discardableResult
  public func x_performRoute(_ route: TBRouter.Route, presentationType: TBPresentationType, data: Any? = nil, animated: Bool = true) -> Bool {
    let routableControllerType: TBRoutable.Type? = TBContainer.getValue(for: route.rawValue)
    guard let controller = routableControllerType?.loadController(with: data, for: route.rawValue) else {
        return false
    }
    self.x_present(controller, type: presentationType, data: data, animated: animated)
    return true
  }
  
}
