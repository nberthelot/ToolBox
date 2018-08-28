//
//  CMTime+Tools.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 20/10/2016.
//  Copyright © 2016 Berthelot Nicolas. All rights reserved.
//

import AVFoundation

public extension CMTime {
  
  public var x_isValid: Bool {
    return CMTIME_IS_VALID(self) == true && value >= 0 && timescale > 0
  }
  
  public func x_timeToFormattedString(_ invalidTimeString: String = "--:--") -> String {
    guard isValid == true && self.seconds.isFinite == true else {
      return invalidTimeString
    }
    return Int(self.seconds).x_secondsToTimeFormattedString(invalidTimeString)
  }
  
}
