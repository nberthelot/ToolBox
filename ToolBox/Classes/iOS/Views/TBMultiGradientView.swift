//
//  TBMultiGradientView.swift
//  ToolBox
//
//  Created by Paride on 12/10/2017.
//  Copyright © 2016 Berthelot Nicolas. All rights reserved.
//

import UIKit

open class TBMultiGradientView: UIView {
   @IBInspectable public var isHorizontal: Bool = false

  public var colors: [UIColor] = [UIColor]() {
    didSet {
      updateColor()
    }
  }
  
  var gradientLayer: CAGradientLayer {
    return layer as! CAGradientLayer
  }
  
  open override class var layerClass : AnyClass {
    return CAGradientLayer.self
  }
  
  fileprivate func updateColor() {
    gradientLayer.colors = colors.map { $0.cgColor }
    if isHorizontal == true {
      gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
      gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
    }
  }
  
}

