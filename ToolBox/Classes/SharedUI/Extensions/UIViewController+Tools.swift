//
//  UIViewController+Tools.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 01/02/2017.
//  Copyright © 2017 Berthelot Nicolas. All rights reserved.
//

import UIKit

public extension UIViewController {
  
  public func x_add(_ childViewController: UIViewController, inContainerView container: UIView) {
    addChildViewController(childViewController)
    container.addSubview(childViewController.view)
    childViewController.view.x_fitTo(container)
    childViewController.didMove(toParentViewController: self)
  }
  
  public var x_isChildviewController: Bool {
    guard let parent = parent else { return false }
    return (parent as? UINavigationController) == nil
  }
  
  public var x_isAppeared: Bool {
    return isViewLoaded == true && view.window != nil
  }
  
}

// MARK: - PRESENT
public extension UIViewController {
  
  public func x_present(_ viewController: UIViewController, type: TBPresentationType, data: Any? = nil, animated flag: Bool = true) {
    switch type {
    case .push:
      navigationController?.x_pushViewController(viewController, animated: flag)
    case .modal:
      present(viewController, animated: flag)
    }
  }
  
}

// MARK: DISMISS
public extension UIViewController {
  
  public func x_dismiss(animated flag: Bool = true, completion: (() -> Void)? = nil) {
    // Modal presentation
    if self.presentingViewController != nil {
      // dissmis presented controller to avoid error
      let completion = { [weak self] in
        self?.dismiss(animated: flag, completion: { completion?() })
      }
      if presentedViewController != nil {
        presentedViewController?.x_dismiss(animated: flag) {
          completion()
        }
        if flag == false { completion() }
      }
      else {
        completion()
      }
    }
      // Push Presentation
    else if let navController = navigationController,
      let topController = navController.topViewController,
      let index = navController.viewControllers.index(of: topController),
      index > 0 {
      // dissmis presented controller to avoid error
      presentedViewController?.x_dismiss(animated: flag, completion: nil)
      _ = navController.x_popViewController(animated: flag) { completion?() }
    }
  }
  
}

// MARK: TOPVIEWCONTROLLER
public extension UIViewController {
  
  var x_topVisibleViewController: UIViewController? {
    guard let presentedViewController = self.presentedViewController else {
      return self
    }
    
    // Manage NavigationController
    if let navigationController = self.presentedViewController as? UINavigationController {
      if let visibleViewController = navigationController.visibleViewController {
        return visibleViewController.x_topVisibleViewController
      }
      return navigationController.x_topVisibleViewController
    }
    
    // Manage TabBarController
    if let tabBarController = self.presentedViewController as? UITabBarController {
      if let selectedViewController = tabBarController.selectedViewController {
        return selectedViewController.x_topVisibleViewController
      }
      return tabBarController.x_topVisibleViewController
    }
    
    return presentedViewController.x_topVisibleViewController
  }
}

