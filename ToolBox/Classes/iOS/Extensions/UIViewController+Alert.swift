//
//  UIViewController+Alert.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 13/02/2017.
//  Copyright © 2017 Berthelot Nicolas. All rights reserved.
//

import UIKit

extension UIViewController {
  
  public func x_displaySystemSingleButtonAlertView(
    _ title: String,
    message: String = String(),
    buttonLabel: String,
    style:  UIAlertAction.Style = .cancel,
    handler: ((UIAlertAction) -> Void)? = nil,
    completion: (() -> Void)? = nil
    ){
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: buttonLabel, style: style, handler: handler))
    present(alertController, animated: true, completion: completion)
  }
  
  public func x_displaySystemDoubleButtonAlertView(
    _ title: String,
    message: String = String(),
    firstButtonLabel: String,
    secondButtonLabel: String,
    firstStyle:  UIAlertAction.Style = .destructive,
    secondStyle:  UIAlertAction.Style = .default,
    firstHandler: ((UIAlertAction) -> Void)? = nil,
    secondHandler: ((UIAlertAction) -> Void)? = nil,
    completion: (() -> Void)? = nil
    ){
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: firstButtonLabel, style: firstStyle, handler: firstHandler))
    alertController.addAction(UIAlertAction(title: secondButtonLabel, style: secondStyle, handler: secondHandler))
    present(alertController, animated: true, completion: completion)
  }
  
}
