//
//  TBRoutable.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 16/10/2017.
//

import Foundation

public protocol TBRoutable: AnyObject {
  
  static func loadController(with data: Any?, for route: String) -> UIViewController?
  
}

public extension TBRoutable where Self: UIViewController {
  
  static func loadController(with data: Any?, for route: String) -> UIViewController? {
    return self.init()
  }

}
