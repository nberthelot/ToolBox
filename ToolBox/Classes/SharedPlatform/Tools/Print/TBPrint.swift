//
//  TBLog.swift
//  Pods
//
//  Created by Nicolas Berthelot on 15/05/2018.
//

import Foundation

public class TBPrint {
  
  public static var categories = [TBPrint.Category.all]
  
}

public func tbPrint(_ items: Any..., category: TBPrint.Category = .none) {
  #if DEBUG
  if TBPrint.categories.contains(category) || TBPrint.categories.contains(.all) {
    let stringItem = items.map {"\($0)"} .joined(separator: " ")
    print(stringItem)
  }
  #endif
}

public func tbDebugPrint(_ items: Any...,  category:  TBPrint.Category = .none) {
  #if DEBUG
  if TBPrint.categories.contains(category) {
    let stringItem = items.map {"\($0)"} .joined(separator: " ")
    debugPrint(stringItem)
  }
  #endif
}

