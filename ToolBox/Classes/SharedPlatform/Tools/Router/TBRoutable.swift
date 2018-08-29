//
//  TBRoutable.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 16/10/2017.
//

import Foundation

public protocol TBRoutable: class {
  
  static func loadController(with data: Any?, for route: String) -> UIViewController?
  
}


