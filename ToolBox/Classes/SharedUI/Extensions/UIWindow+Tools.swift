//
//  UIWindow+Tools.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 09/11/2018.
//

import Foundation
import UIKit

extension UIWindow {
  
  public static func x_createFullScreenWindow(with viewController: UIViewController?, makeKeyAndVisible: Bool = true) -> UIWindow {
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = viewController
    if makeKeyAndVisible {
      window.makeKeyAndVisible()
    }
    return window
  }
  
}
