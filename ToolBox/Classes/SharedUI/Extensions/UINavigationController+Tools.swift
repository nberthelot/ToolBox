//
//  UINavigationController+Tools.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 01/02/2017.
//  Copyright © 2017 Berthelot Nicolas. All rights reserved.
//

import UIKit

public extension UINavigationController {
  
  public func x_pushViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Swift.Void)? = nil) {
    if animated == true {
      CATransaction.begin()
      CATransaction.setCompletionBlock(completion)
      pushViewController(viewController, animated: true)
      CATransaction.commit()
    }
    else {
      pushViewController(viewController, animated: false)
      completion?()
    }
  }
  
  public func x_popViewController(animated: Bool, completion: (() -> Swift.Void)? = nil) -> UIViewController? {
    // TODO: fix it
    let viewController: UIViewController? = popViewController(animated: animated)
    completion?()
    return viewController
  }
  
}
