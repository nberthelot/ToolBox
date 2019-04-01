//
//  Int+Tools.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 20/10/2016.
//  Copyright © 2016 Berthelot Nicolas. All rights reserved.
//

public extension Int {
 
  func x_secondsToTimeFormattedString(_ invalidTimeString: String = "--:--") -> String {
    guard self >= 0 else {
      return invalidTimeString
    }

    let totalSeconds = Int(self)
    let totalSecondsMod3600 = totalSeconds % 3600
    let hours = totalSeconds / 3600
    let minutes = totalSecondsMod3600 / 60
    let seconds = totalSecondsMod3600 % 60
    
    return hours == 0 ? String(format: "%02d:%02d", minutes, seconds) : String(format: "%02d:%02d:%02d", hours, minutes, seconds)
  }
  
  static func x_rand(_ value: Int) -> Int {
    return Int(arc4random_uniform(UInt32(value)))
  }
  
  var x_rand: Int {
    return Int.x_rand(self)
  }
  
  var x_decimalString: String {
    return (self > 10 ? "" : "0") + "\(self)"
  }
}
