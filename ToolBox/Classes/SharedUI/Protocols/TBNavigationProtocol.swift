//
//  TBNavigationProtocol.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 06/11/2017.
//

import Foundation

public protocol TBNavigationProtocol: class {
  func tbWillPresentViewController(_ viewController: UIViewController?, with  data: Any?, animated: Bool)
  func tbDidPresentViewController(_ viewController: UIViewController?, with  data: Any?, animated: Bool)
  func tbWillDismissViewController(_ viewController: UIViewController?, with  data: Any?, animated: Bool)
  func tbDidDismissViewController(_ viewController: UIViewController?, with  data: Any?, animated: Bool)
  func tbPresentedViewController(_ viewController: UIViewController?, didChangeData data: Any?)
}
