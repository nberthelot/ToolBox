//
//  GradientView.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 05/01/2017.
//  Copyright © 2017 Berthelot Nicolas. All rights reserved.
//

import Foundation

public final class TBGradientView: UIView {
  
 @IBInspectable public var startColor: UIColor = UIColor.clear {
    didSet {
      updateColor()
    }
  }
  
  @IBInspectable public var endColor: UIColor = UIColor.clear  {
    didSet {
      updateColor()
    }
  }
  
  var gradientLayer: CAGradientLayer {
    return layer as! CAGradientLayer
  }
  
  @IBInspectable public var isVertical: Bool = true
  
  open override class var layerClass : AnyClass {
    return CAGradientLayer.self
  }
  
  fileprivate func updateColor() {
    gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    if isVertical == false {
      gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
      gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
    }
  }
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    updateColor()
  }
}

