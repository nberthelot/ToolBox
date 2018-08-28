//
//  UIScreen+Tools.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 02/07/2018.
//

import Foundation
import UIKit

extension UIScreen {
  
  public static func x_sizeWithFactor(factor: CGFloat)  -> CGSize {
    let width = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
    let height = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
    return CGSize(width: width, height: height * factor)
  }
  
}
