//
//  Float+Tools.swift
//  Pods
//
//  Created by Nicolas Berthelot on 25/06/2018.
//

import Foundation

extension Float {
  public static func x_valueFromLinearFunction(x: Float, y0: Float, xb: Float, yb: Float,
                                        minValue: Float? = nil, maxValue: Float? = nil) -> Float {
    let b = y0
    let a = (yb - b) / xb
    var res = a * x + b
    
    if let minValue = minValue {
      res = max(res, minValue)
    }
    if let maxValue = maxValue {
      res = min(res, maxValue)
    }
    return res
  }
}
