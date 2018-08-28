//
//  TBKeyboardNotificationsProtocol.swift
//  ToolBox
//
//  Created by Paride on 09/08/16.
//  Copyright © 2016 Berthelot Nicolas. All rights reserved.
//
public protocol TBKeyboardNotificationsProtocol { }

extension TBKeyboardNotificationsProtocol where Self: UIViewController {
  
  public func dismissKeyboard() {
    view.endEditing(true)
  }
  
  //Will show / will hide
  public func registerForKeyboardNotifications(_ selector: Selector) {
    NotificationCenter.default.addObserver(self, selector: selector, name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: selector, name: .UIKeyboardWillHide, object: nil)
  }

  public func unregisterFromKeyboardNotifications() {
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
  }

  //Did hide exclusively
  public func registerForKeyboardDidHideNotification(_ selector: Selector) {
    NotificationCenter.default.addObserver(self, selector: selector, name: .UIKeyboardDidHide, object: nil)
  }
  
  public func unregisterFromKeyboardDidHideNotification() {
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardDidHide, object: nil)
  }
  
  public func retrieveKeyboardInfos(notification: NSNotification) -> (name: NSNotification.Name, duration: TimeInterval, easing: UIViewAnimationOptions, size: CGRect)? {
    guard let infos = notification.userInfo,
      let duration = infos[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval,
      let easing = infos[UIKeyboardAnimationCurveUserInfoKey] as? UInt,
      let size = (infos[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return nil }
    return (name: notification.name, duration: duration, easing: UIViewAnimationOptions(rawValue: easing), size: size)
  }
  
}
