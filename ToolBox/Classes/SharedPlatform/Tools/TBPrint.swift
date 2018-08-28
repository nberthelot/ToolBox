//
//  TBLog.swift
//  Pods
//
//  Created by Nicolas Berthelot on 15/05/2018.
//

import Foundation

public enum PrintCategory {
  case network
  case database
  case data
  case file
  case service
  case ui
  case none
  
  public static var all: [PrintCategory] {
    return [.network, .database, .data, .file, .service, ui, none]
  }
  
}

public class TBPrint {
  public static var categories = PrintCategory.all
}

public func tbPrint(_ items: Any..., category: PrintCategory = .none) {
  #if DEBUG
  if TBPrint.categories.contains(category) {
    let stringItem = items.map {"\($0)"} .joined(separator: " ")
    print(stringItem)
  }
  #endif
}

public func tbDebugPrint(_ items: Any...,  category: PrintCategory = .none) {
  #if DEBUG
  if TBPrint.categories.contains(category) {
    let stringItem = items.map {"\($0)"} .joined(separator: " ")
    debugPrint(stringItem)
  }
  #endif
}

