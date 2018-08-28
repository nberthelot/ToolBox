//
//  UIView+NSlayoutanchor.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 03/10/2016.
//  Copyright © 2016 Berthelot Nicolas. All rights reserved.
//

import UIKit

public extension UIView {
  
  public func x_fitTo(_ view: UIView) {
    translatesAutoresizingMaskIntoConstraints = false
    topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
  }
  
  public func x_fitToCenter(_ view: UIView, width: CGFloat, height: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    widthAnchor.constraint(equalToConstant: width).isActive = true
    heightAnchor.constraint(equalToConstant: height).isActive = true
  }
  
}
