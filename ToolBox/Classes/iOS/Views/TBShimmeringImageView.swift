//
//  TBShimmeringImageView.swift
//  ToolBox
//
//  Created by Berthelot Nicolas on 20/10/2017.
//

import Foundation
import UIKit


open class TBShimmeringImageView: UIImageView, TBShimmeringViewProtocol {
  
  public var gradientLayer = CAGradientLayer()
  
  open func setPlaceholderWithColor(_ color: UIColor, delay: Double = 0) {
    layer.cornerRadius = 4
    layer.backgroundColor = color.cgColor
    layer.masksToBounds = true
    addGradientLayer(lightColor: UIColor.white.withAlphaComponent(0.4), darkColor: UIColor.white)
    addGradientLayerAnimation(delay: delay)
  }
  
  open func resetLayer() {
    removeShimmeringAnimation()
    layer.cornerRadius = 0
    backgroundColor = .clear
    layer.masksToBounds = false
  }
  
}
