//
//  String+Tools.swift
//  ToolBox
//
//  Created by Nicolas Berthelot on 03/04/2017.
//  Copyright © 2017 Berthelot Nicolas. All rights reserved.
//

import Foundation

// MARK: - TRANSORMER
extension String {
  
  public var x_capitalizingFirstLetter: String {
    let first = String(self.prefix(1)).capitalized
    let other = String(self.dropFirst())
    return first + other
  }
  
}


// MARK: - FLOAT
public extension String {
  
  public var x_ratioFloatValue: CGFloat {
    let ratioComporents = self.components(separatedBy: ":")
    var ratioValue = CGFloat(0)
    
    if ratioComporents.count == 2 {
      if let firstComponent = Float(ratioComporents[0]),
        let secondComponent = Float(ratioComporents[1]) {
        ratioValue = CGFloat(firstComponent / secondComponent)
      }
    }
    
    return ratioValue
  }
  
}

// MARK:- LOCALIZE
extension String {
  public var x_loc: String {
    return NSLocalizedString(self, comment: "")
  }
}


// MARK: - TIME
public extension String {
  
  public func x_HHMMSSTimedStringToSecond() -> Int? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "hh:mm:ss"
    var date = dateFormatter.date(from: self)
    if date == nil {
      dateFormatter.dateFormat = "hh:mm:ss.mmm"
      date = dateFormatter.date(from: self)
    }
    
    if let date = date {
      let comp = Calendar.current.dateComponents( [.hour, .minute, .second], from: date)
      let hour = comp.hour ?? 0
      let minute = comp.minute ?? 0
      let second = comp.second ?? 0
      return second + minute * 60 + hour * 3600
    }
    
    return nil
  }
}
