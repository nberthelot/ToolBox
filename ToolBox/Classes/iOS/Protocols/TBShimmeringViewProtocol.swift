//
//  TBShimmeringViewProtocol.swift
//  ToolBox
//
//  Created by Berthelot Nicolas on 20/10/2017.
//

import Foundation

public protocol TBShimmeringViewProtocol: AnyObject {
  var gradientLayer: CAGradientLayer { get set }
}

extension TBShimmeringViewProtocol where Self: UIView {
  
  func addGradientLayer(lightColor: UIColor, darkColor: UIColor) {
    gradientLayer.frame = bounds.insetBy(dx: -frame.width * 0.5, dy: 0)
    gradientLayer.colors = [lightColor.cgColor, darkColor.cgColor, lightColor.cgColor]
    gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
    gradientLayer.locations = [0, 0.1, 0.2]
    layer.mask = gradientLayer
  }
  
  func addGradientLayerAnimation(delay: Double = 0) {
    let gradientAnimation = CABasicAnimation(keyPath: "locations")
    gradientAnimation.fromValue = [0, 0.1, 0.2]
    gradientAnimation.toValue = [0.8, 0.9, 1]
    gradientAnimation.duration = 1.5
    gradientAnimation.beginTime = CACurrentMediaTime() + delay
    gradientAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    gradientAnimation.repeatCount = HUGE
    gradientLayer.add(gradientAnimation, forKey: "gradientAnimation")
  }
  
  func removeShimmeringAnimation() {
    gradientLayer.removeAllAnimations()
    layer.mask = nil
  }
  
}
