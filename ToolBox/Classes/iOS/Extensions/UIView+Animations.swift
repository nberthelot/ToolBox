//
//  UIView+Animations.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 20/01/2017.
//  Copyright © 2017 Berthelot Nicolas. All rights reserved.
//

import UIKit

extension UIView {
  
  public func x_shake(completion: (() -> Void)? = nil) {
    CATransaction.begin()
    let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
    animation.duration = 0.6
    animation.values = [-10, 10, -10, 10, -5, 5, -2.5, 2.5, 0 ]
    layer.add(animation, forKey: "shake")
    CATransaction.setCompletionBlock { completion?() }
    CATransaction.commit()
  }
  
}
