//
//  UIColor+Tools.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 03/02/2017.
//  Copyright © 2017 Berthelot Nicolas. All rights reserved.
//

import UIKit

extension UIColor {
  
  open class var x_random: UIColor {
    return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
  }
  
  public var x_hexSting : String {
    var r = CGFloat(0)
    var g = CGFloat(0)
    var b = CGFloat(0)
    var a = CGFloat(0)
    getRed(&r, green: &g, blue: &b, alpha: &a)
    let red = (Int)(r*255)<<16
    let gren = (Int)(g*255)<<8
    let blue = (Int)(b*255)<<0
    let rgb = red | gren | blue
    return String(format:"%06x", rgb)
  }
  
  public static func x_color(from hexString: String) -> UIColor? {
    let hexString = hexString.replacingOccurrences(of: "#", with: "")
    guard let intHex = UInt(hexString, radix: 16) else {
      return nil
    }
    let hasAlpha = hexString.count == 8
    let r =  (intHex >> (hasAlpha ? 24 : 16)) & 0xff
    let g = (intHex >> (hasAlpha ? 16 : 8)) & 0xff
    let b = (hasAlpha ? intHex >> 8 : intHex) & 0xff
    let a = hasAlpha ? intHex & 0xff : 255
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 255.0)
  }
  
}
